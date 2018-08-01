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
    [self setRightItemWithContentName:@"客服-黑"];
}

#pragma mark - Button Events

- (IBAction)editPasswordButtonEvent:(id)sender
{
    [self loadViewController:@"ModifyPasswordViewController"];
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

- (IBAction)questionButtonEvent:(id)sender
{
    [self loadViewController:@"NormaQuestionViewController"];
}

- (IBAction)logoutButtonEvent:(id)sender
{
    [DIF_CommonHttpAdapter
     httpRequestLogoutResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:DIF_Loaction_Save_UserId];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:DIF_Loaction_Save_Password];
             [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:DIF_Login_Status];
             [[NSUserDefaults standardUserDefaults] synchronize];
             DIF_CommonHttpAdapter.refresh_token = nil;
             DIF_CommonHttpAdapter.access_token = nil;
             DIF_CommonCurrentUser.accessToken = DIF_CommonHttpAdapter.access_token;
             DIF_CommonCurrentUser.refreshToken = DIF_CommonHttpAdapter.refresh_token;
             [DIF_APPDELEGATE loadLoginViewController];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
