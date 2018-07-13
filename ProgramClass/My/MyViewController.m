//
//  MyViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyViewController.h"
#import "MyBaseView.h"

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    m_BaseView = [[MyBaseView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:m_BaseView];
}

@end
