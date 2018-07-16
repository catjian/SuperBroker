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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
                break;
            case 10:
                [strongSelf loadViewController:@"UserInfoViewController" hidesBottomBarWhenPushed:YES];
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

@end
