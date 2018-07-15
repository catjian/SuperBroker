//
//  SetViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"设置"];
    [self setRightItemWithContentName:@"客服"];
}

#pragma mark - Button Events

- (IBAction)editPasswordButtonEvent:(id)sender
{
    [self loadViewController:@"EditPasswordViewController"];
}

- (IBAction)readRegisterFileButtonEvent:(id)sender
{
    OnlyWebViewController *vc = [self loadViewController:@"OnlyWebViewController"];
    [vc setNavTarBarTitle:@"注册协议"];
}

- (IBAction)aboutMeButtonEvent:(id)sender
{
    OnlyWebViewController *vc = [self loadViewController:@"OnlyWebViewController"];
    [vc setNavTarBarTitle:@"关于我们"];
}

- (IBAction)FeedbackButtonEvent:(id)sender
{
    [self loadViewController:@"FeedBackViewController"];
}

- (IBAction)logoutButtonEvent:(id)sender
{
}

@end
