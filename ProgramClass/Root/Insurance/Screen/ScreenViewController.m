//
//  ScreenViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ScreenViewController.h"
#import "ScreenBaseView.h"


@interface ScreenViewController ()

@end

@implementation ScreenViewController
{
    ScreenBaseView *m_BaseView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTarBarTitle:@"更多筛选"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[ScreenBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
    }
}

@end
