//
//  LoanViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/29.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanViewController.h"
#import "LoanBaseView.h"
#import "LoanDetailViewController.h"
#import "LoanScreenViewController.h"

@interface LoanViewController ()

@end

@implementation LoanViewController
{
    LoanBaseView *m_BaseView;
    
    NSString *m_parmsSpeciesId;         //贷款类型(可以多选，逗号相隔)
    NSString *m_parmsLoanCredit;        //额度（字典表）
    NSString *m_parmsDealLimit;         //办理周期(字典)
    NSString *m_parmsLoanLimit;         //借款期限(字典)
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
    [self setNavTarBarTitle:@"贷款"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[LoanBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];DIF_WeakSelf(self);
        [m_BaseView setTopSelectBlock:^(NSInteger index) {
            DIF_StrongSelf
            switch (index) {
                case 0:
                {
                    [strongSelf httpRequestLoanproductSpecies];
                }
                    break;
                case 1:
                {
                    [strongSelf httpRequestLoanCredit];
                }
                    break;
                case 2:
                {
                    [strongSelf httpRequestDealLimit];
                }
                    break;
                default:
                {
                    [strongSelf httpRequestLoanLimit];
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
            [strongSelf httpRequestLoanproductDetailWithListModel:model];
        }];
    }
    [m_BaseView uploadTopButtonStatusWithType:(m_parmsSpeciesId.length>0)
                                         Comp:(m_parmsLoanCredit.length>0)
                                          Age:(m_parmsDealLimit.length >0)
                                       Screen:(m_parmsLoanLimit.length >0)];
}

- (void)setSpeciesId:(NSString *)speciesId
{
    _speciesId = speciesId;
    m_parmsSpeciesId = speciesId;
}

#pragma mark - Http Request

- (void)httpRequestInsuranceProductListWithParameters:(NSDictionary *)parm
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:parm];
    if (m_parmsSpeciesId)
    {
        [parms setObject:m_parmsSpeciesId forKey:@"speciesId"];
    }
    if (m_parmsLoanCredit)
    {
        [parms setObject:m_parmsLoanCredit forKey:@"loanCredit"];
    }
    if (m_parmsDealLimit)
    {
        [parms setObject:m_parmsDealLimit forKey:@"dealLimit"];
    }
    if (m_parmsLoanLimit)
    {
        [parms setObject:m_parmsLoanLimit forKey:@"loanLimit"];
    }
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoanproductListWithParameters:parms
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             
             strongSelf->m_BaseView.loanProModel = [LoanproductModel mj_objectWithKeyValues:responseModel[@"data"]];
             if ([parms[@"pageNum"] integerValue] == 1)
             {
                 strongSelf->m_BaseView.loanProModelArr = strongSelf->m_BaseView.loanProModel.list;
             }
             else if (strongSelf->m_BaseView.loanProModel.list.count > 0)
             {
                 NSMutableArray *listModelArr = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.loanProModelArr];
                 [listModelArr addObjectsFromArray:strongSelf->m_BaseView.loanProModel.list];
                 strongSelf->m_BaseView.loanProModelArr = listModelArr;
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
             strongSelf->m_BaseView.loanProModel = strongSelf->m_BaseView.loanProModel;
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             strongSelf->m_BaseView.loanProModel = strongSelf->m_BaseView.loanProModel;
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             strongSelf->m_BaseView.loanProModel = strongSelf->m_BaseView.loanProModel;
         }
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestLoanproductDetailWithListModel:(RootLoanDetailModel *)model
{
    LoanDetailViewController *vc = [self loadViewController:@"LoanDetailViewController" hidesBottomBarWhenPushed:YES];
    vc.listDetailModel = model;
//    [CommonHUD showHUD];
//    DIF_WeakSelf(self)
//    [DIF_CommonHttpAdapter
//     httpRequestLoanproductDetailWithParameters:@{@"prodId":model.productId}
//     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
//         DIF_StrongSelf
//         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
//         {
//             [CommonHUD hideHUD];
//             LoanDetailViewController *vc = [strongSelf loadViewController:@"LoanDetailViewController" hidesBottomBarWhenPushed:YES];
//             vc.detailModel = [LoanProductDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
//         }
//         else
//         {
//             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
//         }
//     } FailedBlcok:^(NSError *error) {
//         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
//     }];
}

//贷款资质（name=speciesId）列表：http://localhost:40002/api/loanproduct/species
- (void)httpRequestLoanproductSpecies
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoanproductSpeciesWithParameters:nil
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             LoanScreenViewController *vc = [strongSelf loadViewController:@"LoanScreenViewController" hidesBottomBarWhenPushed:YES];
             [vc setNavTarBarTitle:@"贷款资质"];
             vc.isSingle = NO;
             vc.screenDataArr = responseModel[@"data"];
             vc.screenIdStr = strongSelf->m_parmsSpeciesId;
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
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

//贷款额度（name=loanCredit）对应的字典dictCode=100025
- (void)httpRequestLoanCredit
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestDictCodeWithCode:@"100025"
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             LoanScreenViewController *vc = [strongSelf loadViewController:@"LoanScreenViewController" hidesBottomBarWhenPushed:YES];
             [vc setNavTarBarTitle:@"贷款资质"];
             vc.isSingle = YES;
             vc.screenDataArr = responseModel[@"data"];
             vc.screenIdStr = strongSelf->m_parmsLoanCredit;
             [vc setBlock:^(NSArray *response){
                 if (!response || response.count == 0)
                 {
                     strongSelf->m_parmsLoanCredit = nil;
                 }
                 else
                 {
                     strongSelf->m_parmsLoanCredit = [response componentsJoinedByString:@","];
                 }
                 [strongSelf->m_BaseView refreshTableView];
             }];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

//办理周期（name=dealLimit） 对应的字典dictCode=100026
- (void)httpRequestDealLimit
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestDictCodeWithCode:@"100026"
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             LoanScreenViewController *vc = [strongSelf loadViewController:@"LoanScreenViewController" hidesBottomBarWhenPushed:YES];
             [vc setNavTarBarTitle:@"办理周期"];
             vc.isSingle = YES;
             vc.screenDataArr = responseModel[@"data"];
             vc.screenIdStr = strongSelf->m_parmsDealLimit;
             [vc setBlock:^(NSArray *response){
                 if (!response || response.count == 0)
                 {
                     strongSelf->m_parmsDealLimit = nil;
                 }
                 else
                 {
                     strongSelf->m_parmsDealLimit = [response componentsJoinedByString:@","];
                 }
                 [strongSelf->m_BaseView refreshTableView];
             }];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

//借贷期限（name=loanLimit） 对应的字典dictCode=100027
- (void)httpRequestLoanLimit
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestDictCodeWithCode:@"100027"
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             LoanScreenViewController *vc = [strongSelf loadViewController:@"LoanScreenViewController" hidesBottomBarWhenPushed:YES];
             [vc setNavTarBarTitle:@"借贷期限"];
             vc.isSingle = YES;
             vc.screenDataArr = responseModel[@"data"];
             vc.screenIdStr = strongSelf->m_parmsLoanLimit;
             [vc setBlock:^(NSArray *response){
                 if (!response || response.count == 0)
                 {
                     strongSelf->m_parmsLoanLimit = nil;
                 }
                 else
                 {
                     strongSelf->m_parmsLoanLimit = [response componentsJoinedByString:@","];
                 }
                 [strongSelf->m_BaseView refreshTableView];
             }];
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
