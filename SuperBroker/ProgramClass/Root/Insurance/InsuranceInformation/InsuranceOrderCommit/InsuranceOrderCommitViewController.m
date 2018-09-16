//
//  InsturanceOrderCommitViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceOrderCommitViewController.h"
#import "CancelCommitOrderView.h"
#import "MyOrderInsuranceDetailModel.h"

@interface InsuranceOrderCommitViewController ()

@property (weak, nonatomic) IBOutlet UILabel *promotionRewardsLab;
@property (weak, nonatomic) IBOutlet UIImageView *insIcon;
@property (weak, nonatomic) IBOutlet UILabel *insNameLab;
@property (weak, nonatomic) IBOutlet UILabel *insDateLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredNameLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredCardIDLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredRelevanceLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredPhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredEmailLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *createDateLab;
@property (weak, nonatomic) IBOutlet UILabel *managerPhoneLab;


@end

@implementation InsuranceOrderCommitViewController
{
    MyOrderInsuranceDetailModel *m_DetailModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"保险订单提交"];
    [self setRightItemWithContentName:@"客服-黑"];
    [self httpRequestMyOrderInsuranceDetailWithParameters];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)cancelOrderButtonEvent:(id)sender
{    
    CancelCommitOrderView *cancelView = [[CancelCommitOrderView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)];
    [DIF_APPDELEGATE.window addSubview:cancelView];
    [cancelView show];
    DIF_WeakSelf(self)
    [cancelView setBlock:^(BOOL isSuccess) {
        if (isSuccess)
        {
            [CommonHUD showHUDWithMessage:@"取消订单中..."];
            DIF_StrongSelf
            [DIF_CommonHttpAdapter
             httpRequestMyOrderCancelWithParameters:@{@"orderId":strongSelf.detailModel.orderId}
             ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                 DIF_StrongSelf
                 if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
                 {
                     [CommonHUD delayShowHUDWithMessage:@"取消订单成功"];
                     [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                 }
                 else
                 {
                     [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
                 }
             } FailedBlcok:^(NSError *error) {
                 [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
             }];
        }
    }];
}

- (void)loadContentView
{
    [self.insIcon sd_setImageWithURL:[NSURL URLWithString:m_DetailModel.productUrl]];
    [self.insNameLab setText:m_DetailModel.productName];
    [self.insDateLab setText:[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_DetailModel.createTime.integerValue/1000]
                                              Formate:@"yyyy-MM-dd HH:mm"]];
    [self.promotionRewardsLab setText:[NSString stringWithFormat:@"推广奖励：%@元",m_DetailModel.generalizeAmount]];
    MyOrderInsuranceDetailInsuredInfoModel *insuredInfoModel = [MyOrderInsuranceDetailInsuredInfoModel mj_objectWithKeyValues:self.customInfo];
    [self.insuredNameLab setText:[NSString stringWithFormat:@"姓名：%@",insuredInfoModel.insuredName]];
    [self.insuredCardIDLab setText:[NSString stringWithFormat:@"身份证号：%@",insuredInfoModel.certificate]];
    [self.insuredRelevanceLab setText:[NSString stringWithFormat:@"投保关系：%@",insuredInfoModel.insuredRelation]];
    [self.insuredPhoneLab setText:[NSString stringWithFormat:@"联系方式：%@",insuredInfoModel.insuredPhone]];
    [self.insuredEmailLab setText:[NSString stringWithFormat:@"邮箱：%@",insuredInfoModel.insuredEmail?insuredInfoModel.insuredEmail:@""]];
    [self.orderNumLab setText:[NSString stringWithFormat:@"订单编号：%@",m_DetailModel.orderCode]];
    [self.createDateLab setText:[NSString stringWithFormat:@"创建时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_DetailModel.createTime.integerValue/1000]
                                                 Formate:@"yyyy-MM-dd HH:mm"]]];
}

#pragma mark - HttpRequest

- (void)httpRequestMyOrderInsuranceDetailWithParameters
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyOrderInsuranceDetailWithParameters:@{@"orderId":self.detailModel.orderId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD hideHUD];
             strongSelf->m_DetailModel = [MyOrderInsuranceDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             [strongSelf performSelectorOnMainThread:@selector(loadContentView) withObject:nil waitUntilDone:YES];
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
