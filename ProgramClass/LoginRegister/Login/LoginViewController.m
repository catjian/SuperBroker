//
//  LoginViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *openSecure;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self.userID setText:@"18888888001"];
    [self.password setText:@"123456"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event
- (IBAction)loginButtonEvent:(id)sender
{
    [CommonHUD showHUDWithMessage:@"登录中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoginWithParameters:@{@"brokerPhone":self.userID.text,
                                      @"password":self.password.text
                                      }
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD delayShowHUDWithMessage:@"登录成功"];
             [strongSelf dismissViewControllerAnimated:YES completion:nil];
             [[NSUserDefaults standardUserDefaults] setObject:strongSelf.userID.text
                                                       forKey:DIF_Loaction_Save_UserId];
             [[NSUserDefaults standardUserDefaults] setObject:strongSelf.password.text
                                                       forKey:DIF_Loaction_Save_Password];
             [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:DIF_Login_Status];
             [[NSUserDefaults standardUserDefaults] synchronize];
             DIF_CommonCurrentUser.accessToken = DIF_CommonHttpAdapter.access_token;
             DIF_CommonCurrentUser.refreshToken = DIF_CommonHttpAdapter.refresh_token;
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:@"登录失败"];
         }
     }
     FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
};

- (IBAction)openPasswordSecureButtonEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self.password setSecureTextEntry:sender.selected];
}

- (IBAction)gotoRegisterButtonEvent:(id)sender
{
    [self loadViewController:@"RegisterViewController"];
}

- (IBAction)gotoForgetPasswordButtonEvent:(id)sender
{
    [self loadViewController:@"EditPasswordViewController"];
}

- (IBAction)gotoVerifyCodeLoginButtonEvent:(id)sender
{
    [self loadViewController:@"SMSLoginViewController"];
}

@end
