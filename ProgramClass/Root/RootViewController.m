//
//  RootViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewController.h"
#import "RootBaseView.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    RootBaseView *m_BaseView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
}

- (void)viewDidLoad
{
    self.ShowBackButton = NO;
    [super viewDidLoad];
    [self setNavTarBarTitle:@"易保金服"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[RootBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            if (indexPath.row == 0)
            {
                [strongSelf loadViewController:@"InsuranceViewController" hidesBottomBarWhenPushed:NO];
            }
        }];
    }
}

@end
