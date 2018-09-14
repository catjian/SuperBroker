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

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        if ([self.urlString rangeOfString:@"http"].location != NSNotFound)
        {
            
        }
        else if ([self.urlString rangeOfString:@"SuperBroker.app"].location != NSNotFound)
        {
            [m_BaseView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.urlString]]];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.view addSubview:line];
    }
}

@end
