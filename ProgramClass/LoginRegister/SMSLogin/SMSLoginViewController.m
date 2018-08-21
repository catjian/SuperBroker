//
//  SMSLoginViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SMSLoginViewController.h"

@interface SMSLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;

@end

@implementation SMSLoginViewController
{
    int m_TimeOut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self.phoneTF setDelegate:self];
    [self.getVerifyCodeBtn.layer setCornerRadius:5];
    [self.getVerifyCodeBtn.layer setMasksToBounds:YES];
    m_TimeOut = 0;
}

#pragma mark - Button Event

- (IBAction)getVerifyButtonEvent:(id)sender
{
    if (m_TimeOut > 0)
    {
        return;
    }
    if (![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestSmsLoginSmsCodeWithParameters:@{@"brokerPhone":self.phoneTF.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             strongSelf->m_TimeOut = 60;
             [strongSelf.getVerifyCodeBtn setBackgroundColor:[UIColor grayColor]];
             [strongSelf reloadVerifyButtonTimeOut];
         }
         [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)reloadVerifyButtonTimeOut
{
    [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",m_TimeOut] forState:UIControlStateNormal];
    m_TimeOut--;
    if (m_TimeOut > 0)
    {
        [self performSelector:@selector(reloadVerifyButtonTimeOut) withObject:nil afterDelay:1];
    }
    else
    {
        [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getVerifyCodeBtn setBackgroundColor:DIF_HEXCOLOR(@"0070FF")];
    }
}

- (IBAction)SMSLoginButtonEvent:(id)sender
{
    if (![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.verifyTF.text <= 0)
    {
        [self.view makeToast:@"请输入验证码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUDWithMessage:@"登录中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestSmsLoginWithParameters:@{@"brokerPhone":self.phoneTF.text,
                                         @"verifyCode":self.verifyTF.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD delayShowHUDWithMessage:@"登录成功"];
             [strongSelf dismissViewControllerAnimated:YES completion:nil];
             [[NSUserDefaults standardUserDefaults] setObject:strongSelf.phoneTF.text
                                                       forKey:DIF_Loaction_Save_UserId];
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
}

- (IBAction)gotoNormalLoginButtonEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gotoRegisterButtonEvent:(id)sender
{
    [self loadViewController:@"RegisterViewController"];
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
    if ([textField isEqual:self.phoneTF] && textField.text.length + string.length > 11)
    {
        return NO;
    }
    return YES;
}
@end
