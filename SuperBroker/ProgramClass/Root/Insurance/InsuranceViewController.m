//
//  InsuranceViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceViewController.h"
#import "InsuranceBaseView.h"
#import "InsuranceDetailViewController.h"
#import "InsuranceTypesViewController.h"
#import "InsuranceCompanyViewController.h"
#import "InsuranceAgeViewController.h"
#import "ScreenViewController.h"

@interface InsuranceViewController ()<UITextFieldDelegate>

@end

@implementation InsuranceViewController
{
    InsuranceBaseView *m_BaseView;
    UITextField *m_SearchTextField;
    UIView *m_SearchView;
    InsuranceProductModel *m_DataModel;
    NSString *m_parmsAge;               //年龄段（字典表）
    NSString *m_parmsSpeciesId;         //险种
    NSString *m_parmsCompId;            //保险公司id
    NSString *m_parmsConsumptionType;   //是否消费型（57不限45消费型46返还型），也不能多选
    NSString *m_parmsOrderType;         //排序（默认55或者null根据isTop排序，56时间排序），排序不能多选
    NSString *m_parmsCompName;          //保险名称
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DIF_ShowTabBarAnimation(YES);
    m_DataModel = [InsuranceProductModel new];
    [self setRightItemWithContentName:@" 搜索"];
    [self createSearchView];
    [self.navigationItem setTitleView:m_SearchView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[InsuranceBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self);
        [m_BaseView setScrollBlock:^(UITableView *tableView, UIScrollView *scrollView) {
            DIF_StrongSelf
            [strongSelf->m_SearchView endEditing:YES];
        }];
        [m_BaseView setTopSelectBlock:^(NSInteger index) {
            DIF_StrongSelf
            switch (index) {
                case 0:
                {
                    InsuranceTypesViewController * vc =
                    [strongSelf loadViewController:@"InsuranceTypesViewController"];
                    vc.speciesIdStr = strongSelf->m_parmsSpeciesId;
                    [vc setBlock:^(NSArray *response){
                        if (!response || response.count == 0)
                        {
                            strongSelf->m_parmsSpeciesId = nil;
                        }
                        else
                        {
                            strongSelf->m_parmsSpeciesId = [response componentsJoinedByString:@","];
                        }
                        [strongSelf->m_BaseView refreshTableView];
                    }];
                }
                    break;
                case 1:
                {
                    InsuranceCompanyViewController * vc =
                    [strongSelf loadViewController:@"InsuranceCompanyViewController"];
                    vc.compIdStr = strongSelf->m_parmsCompId;
                    [vc setBlock:^(NSArray *response){
                        if (!response || response.count == 0)
                        {
                            strongSelf->m_parmsCompId = nil;
                        }
                        else
                        {
                            strongSelf->m_parmsCompId = [response componentsJoinedByString:@","];
                        }
                        [strongSelf->m_BaseView refreshTableView];
                    }];
                }
                    break;
                case 2:
                {
                    InsuranceAgeViewController * vc =
                    [strongSelf loadViewController:@"InsuranceAgeViewController"];
                    vc.ageStr = strongSelf->m_parmsAge;
                    [vc setBlock:^(NSArray *response){
                        if (!response || response.count == 0)
                        {
                            strongSelf->m_parmsAge = nil;
                        }
                        else
                        {
                            strongSelf->m_parmsAge = [response componentsJoinedByString:@","];
                        }
                        [strongSelf->m_BaseView refreshTableView];
                    }];
                }
                    break;
                default:
                {
                    ScreenViewController * vc =
                    [strongSelf loadViewController:@"ScreenViewController"];
                    vc.orderTypeStr = strongSelf->m_parmsOrderType;
                    vc.consumptionTypeStr = strongSelf->m_parmsConsumptionType;
                    [vc setBlock:^(NSArray *OrderType,NSArray *ConsumptionType){
                        if (!OrderType || OrderType.count == 0)
                        {
                            strongSelf->m_parmsOrderType = nil;
                        }
                        else
                        {
                            strongSelf->m_parmsOrderType = [OrderType componentsJoinedByString:@","];
                        }
                        if (!ConsumptionType || ConsumptionType.count == 0)
                        {
                            strongSelf->m_parmsConsumptionType = nil;
                        }
                        else
                        {
                            strongSelf->m_parmsConsumptionType = [ConsumptionType componentsJoinedByString:@","];
                        }
                        [strongSelf->m_BaseView refreshTableView];
                    }];
                }
                    break;
            }
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            [strongSelf httpRequestInsuranceProductListWithParameters:@{@"pageNum":[@(1) stringValue],@"pageSize":@"10"}];
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            [strongSelf httpRequestInsuranceProductListWithParameters:@{@"pageNum":[@(page+1) stringValue],@"pageSize":@"10"}];
        }];
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            [strongSelf httpRequestInsuranceProductDetailWithListModel:model];
        }];
    }
    [m_BaseView uploadTopButtonStatusWithType:(m_parmsSpeciesId.length>0)
                                         Comp:(m_parmsCompId.length>0)
                                          Age:(m_parmsAge.length >0)
                                       Screen:(m_parmsOrderType.length >0 || m_parmsConsumptionType.length > 0)];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self searchButtonEvent];
}

#pragma mark - Search Event Object

- (void)createSearchView
{
    CGFloat loseWidth = (is_iPhone5AndEarly?100:(is_iPhone6?110:120));
    m_SearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width-loseWidth, 29)];
    [m_SearchView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *backView = [[UIView alloc] initWithFrame:m_SearchView.frame];
    [backView setBackgroundColor:DIF_HEXCOLOR(@"f2f2f3")];
    [backView.layer setCornerRadius:5];
    [backView.layer setMasksToBounds:YES];
    [m_SearchView addSubview:backView];
    
    m_SearchTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, backView.width-24, backView.height)];
    [m_SearchTextField setFont:DIF_UIFONTOFSIZE(14)];
    [m_SearchTextField setDelegate:self];
    [m_SearchTextField setClearButtonMode:UITextFieldViewModeUnlessEditing|UITextFieldViewModeWhileEditing];
    [backView addSubview:m_SearchTextField];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@""];
    [placeholder FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, placeholder.length)];
    [placeholder ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"cccccc") Range:NSMakeRange(0, placeholder.length)];
    [placeholder attatchImage:[UIImage imageNamed:@"搜索"]
                   imageFrame:CGRectMake(0, -(m_SearchTextField.height-18)/2, 18, 18)
                        Range:NSMakeRange(0, 0)];
    [m_SearchTextField setAttributedPlaceholder:placeholder];
    
//    UIButton *cleanBtn = [CommonCommitButton commitButtonWithFrame:CGRectMake(0, 0, DIF_PX(30), DIF_PX(30)) Title:nil TitleColor:nil BackGroundColor:nil];
//    [cleanBtn setCenterY:m_SearchTextField.centerY];
//    [cleanBtn setRight:backView.width-DIF_PX(30)];
//    [cleanBtn addTarget:self action:@selector(cleanSearchText) forControlEvents:UIControlEventTouchUpInside];
//    [cleanBtn setImage:[UIImage imageNamed:@"TFClean"] forState:UIControlStateNormal];
//    [backView addSubview:cleanBtn];
}

- (void)cleanSearchText
{
    [m_SearchTextField setText:nil];
    [m_BaseView refreshTableView];
}

- (void)searchButtonEvent
{
    [self.view endEditing:YES];
    m_parmsCompName = m_SearchTextField.text;
    [m_SearchTextField resignFirstResponder];
    if ([CommonVerify isContainsEmoji:m_SearchTextField.text])
    {
        [self.view makeToast:@"关键字不能包含表情"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [m_BaseView refreshTableView];
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";     //九宫格的输入值
    if (string && [other rangeOfString:string].location == NSNotFound && ([string isEqualToString:@" "] || [CommonVerify isContainsEmoji:string]))
    {
        return NO;
    }
    if (!string || string.isNull)
    {
        if (textField.text.length == 1)
        {
        }
        return YES;
    }
    if (textField.text.length + string.length > 18)
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [m_BaseView refreshTableView];
    m_parmsCompName = nil;
    return YES;
}

#pragma mark - Http Request

- (void)httpRequestInsuranceProductListWithParameters:(NSDictionary *)parm
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parm];
    if (m_parmsAge)
    {
        [parms setObject:m_parmsAge forKey:@"age"];
    }
    if (m_parmsSpeciesId)
    {
        [parms setObject:m_parmsSpeciesId forKey:@"speciesId"];
    }
    if (m_parmsCompId)
    {
        [parms setObject:m_parmsCompId forKey:@"compId"];
    }
    if (m_parmsConsumptionType)
    {
        [parms setObject:m_parmsConsumptionType forKey:@"consumptionType"];
    }
    if (m_parmsOrderType)
    {
        [parms setObject:m_parmsOrderType forKey:@"orderType"];
    }
    if (m_parmsCompName)
    {
        [parms setObject:m_parmsCompName forKey:@"compName"];
    }
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceProductListWithParameters:parms
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             strongSelf->m_BaseView.insuranceProductModel = [InsuranceProductModel mj_objectWithKeyValues:responseModel[@"data"]];
             if ([parms[@"pageNum"] integerValue] == 1)
             {
                 strongSelf->m_BaseView.insuranceProductModelArr = strongSelf->m_BaseView.insuranceProductModel.list;
             }
             else if (strongSelf->m_BaseView.insuranceProductModel.list.count > 0)
             {
                 NSMutableArray *listModelArr = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.insuranceProductModelArr];
                 [listModelArr addObjectsFromArray:strongSelf->m_BaseView.insuranceProductModel.list];
                 strongSelf->m_BaseView.insuranceProductModelArr = listModelArr;
             }
         }
         else
         {
             if ([responseModel[@"message"] rangeOfString:@"网络连接失败"].location != NSNotFound )
             {
                 [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             }
             else
             {
                 [strongSelf->m_BaseView setNoDataImageName:@"数据错误"];
             }
             strongSelf->m_BaseView.insuranceProductModel = strongSelf->m_BaseView.insuranceProductModel;
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             strongSelf->m_BaseView.insuranceProductModel = strongSelf->m_BaseView.insuranceProductModel;
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             strongSelf->m_BaseView.insuranceProductModel = strongSelf->m_BaseView.insuranceProductModel;
         }
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestInsuranceProductDetailWithListModel:(InsuranceProductDetailModel *)model
{
//    InsuranceDetailViewController *vc = [self loadViewController:@"InsuranceDetailViewController" hidesBottomBarWhenPushed:YES];
//    vc.productModel = model;
    
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceProductDetailWithParameters:@{@"prodId":model.prodId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
        DIF_StrongSelf
        if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
        {
            [CommonHUD hideHUD];
            InsuranceDetailViewController *vc = [strongSelf loadViewController:@"InsuranceDetailViewController" hidesBottomBarWhenPushed:YES];
            vc.detailModel = [InsuranceProductDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
            vc.productModel = model;
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
