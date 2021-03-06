//
//  MyViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyViewController.h"
#import "MyBaseView.h"
#import "UserInfoViewController.h"
#import "PresentAccountViewController.h"
#import "IncomeListViewController.h"
#import "PaymentListViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
{
    MyBaseView *m_BaseView;
    BrokerInfoDataModel *m_BrokerInfoModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
    [self.navigationController setNavigationBarHidden:YES];
    [self httpRequestGetBrokerInfo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[MyBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self);
        [m_BaseView setTopBtnBlock:^(NSInteger tag) {
            DIF_StrongSelf
            switch (tag) {
                case 9900:
                    [strongSelf loadViewController:@"BuyMemeberViewController" hidesBottomBarWhenPushed:YES];                
                    break;
                case 9901:                
                    [strongSelf loadViewController:@"PaymentListViewController" hidesBottomBarWhenPushed:YES];
                    break;
                case 9902:
                    [strongSelf loadViewController:@"PresentEventViewController" hidesBottomBarWhenPushed:YES];
                    break;
                default:
                    break;
            }
            
        }];
        
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            NSInteger index = indexPath.section*10+indexPath.row;
            switch (index)
            {
                case 0:
                    [strongSelf loadViewController:@"MyOrderListViewController" hidesBottomBarWhenPushed:YES];
                    break;
                case 10:
                {
                    UserInfoViewController *vc = [strongSelf loadViewController:@"UserInfoViewController" hidesBottomBarWhenPushed:YES];
                    vc.brokerInfoModel = strongSelf->m_BrokerInfoModel;
                }
                    break;
                case 11:
                    [strongSelf loadViewController:@"PresentAccountViewController" hidesBottomBarWhenPushed:YES];
                    break;
                case 12:
                    [strongSelf loadViewController:@"IncomeListViewController" hidesBottomBarWhenPushed:YES];
                    break;
                case 13:
                    [strongSelf loadViewController:@"InviteListViewController" hidesBottomBarWhenPushed:YES];
                    break;
                case 20:
                    [strongSelf loadViewController:@"SetViewController" hidesBottomBarWhenPushed:YES];
                    break;
                default:
                    break;
            }
        }];
    }
}

#pragma mark - http Request

- (void)httpRequestGetBrokerInfo
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestBrokerinfoWithResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             NSDictionary *data = responseModel[@"data"];
             strongSelf->m_BrokerInfoModel = [BrokerInfoDataModel mj_objectWithKeyValues:data];
             [strongSelf->m_BaseView setBrokerInfoModel:strongSelf->m_BrokerInfoModel];
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
