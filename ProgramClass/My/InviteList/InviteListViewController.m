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
    [self setRightItemWithContentName:@"客服"];
    m_ListModel = [InviteListModel new];
    m_BaseView = [[InviteListBaseView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_BaseView.listModel = m_ListModel;
    [self.view addSubview:m_BaseView];
}

@end
