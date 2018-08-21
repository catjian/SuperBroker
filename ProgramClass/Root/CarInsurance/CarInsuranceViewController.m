//
//  CarInsuranceViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceViewController.h"
#import "CarInsuranceBaseView.h"
#import "CarInsuranceInfoViewController.h"

@interface CarInsuranceViewController ()

@end

@implementation CarInsuranceViewController
{
    CarInsuranceBaseView *m_BaseView;
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
    [self setNavTarBarTitle:@"车险服务"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[CarInsuranceBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            if (DIF_APPDELEGATE.brokerInfoModel.brokerType.integerValue == 64)
            {
                [strongSelf.view makeToast:@"普通经纪人无权购买车险/保险" duration:2 position:CSToastPositionCenter];
                return;
            }
            CarInsuranceInfoViewController *vc = [strongSelf loadViewController:@"CarInsuranceInfoViewController" hidesBottomBarWhenPushed:YES];
            vc.detailModel = model;
        }];
        [self httpRequestInsuranceCarProductList];
    }
}

#pragma mark - Http Request

- (void)httpRequestInsuranceCarProductList
{
    NSDictionary *parms = @{};
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceCarProductListResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_BaseView.productArr = responseModel[@"data"];
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
