//
//  CarInsuranceViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceViewController.h"
#import "CarInsuranceBaseView.h"

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
            [strongSelf loadViewController:@"CarInsuranceInfoViewController" hidesBottomBarWhenPushed:YES];
        }];
    }
}

@end
