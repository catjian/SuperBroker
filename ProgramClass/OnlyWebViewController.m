//
//  OnlyWebViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "OnlyWebViewController.h"

@interface OnlyWebViewController ()

@end

@implementation OnlyWebViewController
{
    UIWebView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
    }
}

@end
