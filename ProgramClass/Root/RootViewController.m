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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavTarBarTitle:@"易保金服"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    m_BaseView = [[RootBaseView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:m_BaseView];
}

@end
