//
//  CarInsuranceBusinessViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceBusinessViewController.h"
#import "CarInsuranceBusinessBaseView.h"
#import "CarInsuranceCommitViewController.h"

@interface CarInsuranceBusinessViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonView;
@property (weak, nonatomic) IBOutlet UILabel *generalizeAmount;

@end

@implementation CarInsuranceBusinessViewController
{
    CarInsuranceBusinessBaseView *m_BaseView;
    NSArray *m_carspeciesList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"车险服务"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.isCanEdit)
    {
        [self.bottomButtonView setHidden:YES];
        self.contentView.height += self.bottomButtonView.height;
    }
    if (!m_BaseView)
    {
        m_BaseView = [[CarInsuranceBusinessBaseView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
        m_BaseView.isCanEdit = self.isCanEdit;
        [self.contentView addSubview:m_BaseView];
        [self.generalizeAmount setText:[NSString stringWithFormat:@"推广奖励%@元",self.generalizeAmountNum]];
        if (self.isCanEdit)
        {
            [self httpRequestCarSpeciesList];            
        }
        else
        {
            m_BaseView.carspeciesList = self.carspeciesList;
        }
        
        DIF_WeakSelf(self)
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            CarsPeciesDataDetailModel *datemodel = [CarsPeciesDataDetailModel mj_objectWithKeyValues:strongSelf->m_carspeciesList[indexPath.section]];
            CarSpeciesDataListDetailModel *detailModel = [CarSpeciesDataListDetailModel mj_objectWithKeyValues:datemodel.insuranceCarSpeciesList[indexPath.row]];
            __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
            [popPickerView setHeight:DIF_PX(270)];
            CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
            [pickerView setPickerDatas:detailModel.selectList];
            [popPickerView addSubview:pickerView];
            [popPickerView showPopView];
            [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
                DIF_StrongSelf
                [popPickerView hidePopView];
                if ([x isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *content = [x objectForKey:@"SuccessButtonEvent"];
                    NSMutableArray *carspeciesList = [NSMutableArray arrayWithArray:strongSelf->m_carspeciesList];
                    CarsPeciesDataDetailModel *datemodel = [CarsPeciesDataDetailModel mj_objectWithKeyValues:carspeciesList[indexPath.section]];
                    NSMutableArray *insuranceCarSpeciesList = [NSMutableArray arrayWithArray:datemodel.insuranceCarSpeciesList];
                    CarSpeciesDataListDetailModel *detailModel = [CarSpeciesDataListDetailModel mj_objectWithKeyValues:insuranceCarSpeciesList[indexPath.row]];
                    detailModel.selectMoney = content[@"content"];
                    [insuranceCarSpeciesList replaceObjectAtIndex:indexPath.row withObject:detailModel];
                    datemodel.insuranceCarSpeciesList = insuranceCarSpeciesList;
                    [carspeciesList replaceObjectAtIndex:indexPath.section withObject:datemodel];
                    strongSelf->m_carspeciesList = carspeciesList;
                    strongSelf->m_BaseView.carspeciesList = strongSelf->m_carspeciesList;
                }
            }];
        }];
    }
}

- (IBAction)userServerButtonEvent:(id)sender
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)commitButtonEvent:(id)sender
{
    [CommonHUD showHUDWithMessage:@"正在提交车险订单..."];
    NSMutableArray *species = [NSMutableArray array];
    for (int i = 0; i < m_carspeciesList.count; i++)
    {
        CarsPeciesDataDetailModel *model = [CarsPeciesDataDetailModel mj_objectWithKeyValues:m_carspeciesList[i]];
        for (int j = 0; j < model.insuranceCarSpeciesList.count; j++)
        {
            CarSpeciesDataListDetailModel *detailModel = [CarSpeciesDataListDetailModel mj_objectWithKeyValues:model.insuranceCarSpeciesList[j]];
            CarInsuranceBusinessViewCell *cell = [m_BaseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            NSString *modelId = model.insuranceCarSpeciesList[j][@"id"];
            [species addObject:@{@"id": modelId,
                                 @"insuredAmount": detailModel.selectMoney,
                                 @"isDeductible": detailModel.isDeductible.integerValue==1?@"":(cell.isDeductible?@"1":@"0")}];
        }
    }
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestCarOrderWithParameters:@{@"productId":self.detailModel.productId,
                                         @"insuredName":self.buyCustomDetail.userName,
                                         @"insuredPhone":self.buyCustomDetail.userPhone,
                                         @"province":[self.buyCustomDetail.city componentsSeparatedByString:@" "].firstObject,
                                         @"city":[self.buyCustomDetail.city componentsSeparatedByString:@" "].lastObject,
                                         @"carOwnerName":self.buyCustomDetail.carOwner,
                                         @"carOwnerCertificate":self.buyCustomDetail.ownerCardId,
                                         @"carOwnerCertificateUrl":self.buyCustomDetail.userIDCardPic,
                                         @"carArea":self.buyCustomDetail.cityNum,
                                         @"carNumber":self.buyCustomDetail.plateNum,
                                         @"carIdentificationCode":self.buyCustomDetail.VINStr,
                                         @"carEngineCode":self.buyCustomDetail.engineNum,
                                         @"carRegisterTime":self.buyCustomDetail.registerDate,
                                         @"carOilType":self.buyCustomDetail.oilType,
                                         @"carDrivingLicenseUrl":self.buyCustomDetail.driverCardPic,
                                         @"species":species }
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             CarInsuranceCommitViewController *vc = [strongSelf loadViewController:@"CarInsuranceCommitViewController"];
             vc.carOrderId = responseModel[@"data"];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)setCarspeciesList:(NSArray *)carspeciesList
{
    _carspeciesList = carspeciesList;
    if (m_BaseView)
    {
        m_BaseView.carspeciesList = carspeciesList;
    }
}

#pragma mark - Http Request

- (void)httpRequestCarSpeciesList
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestCarSpeciesListWithParameters:@{@"productId":self.detailModel.productId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_carspeciesList = responseModel[@"data"];
             strongSelf->m_BaseView.carspeciesList = responseModel[@"data"];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
