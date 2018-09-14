//
//  LoginViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *openSecure;
@property (weak, nonatomic) IBOutlet UITextField *serverUrlTF;

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
    [self.userID setText:@"13657202472"];//15607185136 13657202472 18502761623 13376819810
    [self.password setText:@"123456"];
//    [self.userID setText:[[NSUserDefaults standardUserDefaults] stringForKey:DIF_Loaction_Save_UserId]];
    [self.userID setDelegate:self];
    [self.password setDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event
- (IBAction)loginButtonEvent:(id)sender
{
    if (self.serverUrlTF.text.length > 0)
    {
        [DIF_CommonHttpAdapter setBaseUrl:self.serverUrlTF.text];
    }
    if (![CommonVerify isMobileNumber:self.userID.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.password.text.length < 6)
    {
        [self.view makeToast:@"请设置6~18位数的密码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [self.view endEditing:YES];
    [CommonHUD showHUDWithMessage:@"登录中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoginWithParameters:@{@"brokerPhone":self.userID.text,
                                      @"password":self.password.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD delayShowHUDWithMessage:@"登录成功"];
             [[NSUserDefaults standardUserDefaults] setObject:strongSelf.userID.text
                                                       forKey:DIF_Loaction_Save_UserId];
             [[NSUserDefaults standardUserDefaults] setObject:strongSelf.password.text
                                                       forKey:DIF_Loaction_Save_Password];
             [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:DIF_Login_Status];
             [[NSUserDefaults standardUserDefaults] synchronize];
             DIF_CommonCurrentUser.accessToken = DIF_CommonHttpAdapter.access_token;
             DIF_CommonCurrentUser.refreshToken = DIF_CommonHttpAdapter.refresh_token;
             [DIF_APPDELEGATE httpRequestIMUserSig];
             [DIF_APPDELEGATE httpRequestMyBrokerAmount];
             [DIF_APPDELEGATE httpRequestGetBrokerInfo];
             [strongSelf dismissViewControllerAnimated:YES completion:^{
                 [DIF_TabBar setSelectedIndex:0];
             }];
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
    [self loadViewController:@"ModifyPasswordViewController"];
}

- (IBAction)gotoVerifyCodeLoginButtonEvent:(id)sender
{
    [self loadViewController:@"SMSLoginViewController"];
}

#pragma mark - TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string || string.isNull)
    {
        return YES;
    }
    if (textField.text.length == 0 && [string isEqualToString:@" "])
    {
        return NO;
    }
    if ([textField isEqual:self.userID] && textField.text.length + string.length > 11)
    {
        return NO;
    }
    if ([textField isEqual:self.password] && textField.text.length + string.length > 18)
    {
        return NO;
    }
    return YES;
}

@end
