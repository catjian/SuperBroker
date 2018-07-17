//
//  InviteListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InviteListViewController.h"
#import "InviteListBaseView.h"

@interface InviteListViewController ()

@end

@implementation InviteListViewController
{
    InviteListBaseView *m_BaseView;
    InviteListModel *m_ListModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"我的邀请"];
    [self setRightItemWithContentName:@"客服-黑"];
    m_ListModel = [InviteListModel new];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 12)];
    [topView setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self.view addSubview:topView];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [topView addSubview:lineT];
    
    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, 11, DIF_SCREEN_WIDTH, 1)];
    [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [topView addSubview:lineB];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[InviteListBaseView alloc] initWithFrame:CGRectMake(0, 12, self.view.width, self.view.height-12) style:UITableViewStylePlain];
        m_BaseView.listModel = m_ListModel;
        [self.view addSubview:m_BaseView];
    }
}

@end
