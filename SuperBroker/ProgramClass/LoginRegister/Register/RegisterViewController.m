//
//  RegisterViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *openSecureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *isRead;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;

@end

@implementation RegisterViewController
{
    int m_TimeOut;
}

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
    [self.phoneTF setDelegate:self];
    [self.passwordTF setDelegate:self];
    [self.getVerifyCodeBtn.layer setCornerRadius:4];
    [self.getVerifyCodeBtn.layer setMasksToBounds:YES];
    m_TimeOut = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event

- (IBAction)getVerifyCodeButtonEvent:(id)sender
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
     httpRequestRegistrySmsCodeWithParameters:@{@"brokerPhone":self.phoneTF.text}
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

- (IBAction)openPasswordSecureButtonEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self.passwordTF setSecureTextEntry:sender.selected];
}

- (IBAction)registerButtonEvent:(id)sender
{
    if (!self.registerBtn.selected)
    {
        return;
    }
    if (![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.verifyCodeTF.text <= 0)
    {
        [self.view makeToast:@"请输入验证码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.passwordTF.text.length < 6)
    {
        [self.view makeToast:@"请设置6~18位数的密码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.inviteCodeTF.text.length < 1)
    {
        [self.view makeToast:@"请输入邀请码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUDWithMessage:@"注册中..."];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:self.phoneTF.text forKey:@"brokerPhone"];
    [parmas setObject:self.verifyCodeTF.text forKey:@"verifyCode"];
    [parmas setObject:self.passwordTF.text forKey:@"password"];
    [parmas setObject:self.inviteCodeTF.text forKey:@"parentInviteCode"];
    [DIF_CommonHttpAdapter
     httpRequestRegistryWithParameters:parmas
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD delayShowHUDWithMessage:@"注册成功"];
             [self.navigationController popToRootViewControllerAnimated:YES];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (IBAction)gotoLoginButtonEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)readButtonEvent:(UIButton *)sender
{
    self.registerBtn.selected = !self.registerBtn.selected;
    [self.isRead setImage:[UIImage imageNamed:(self.registerBtn.selected?@"已阅":@"未阅")]];
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
    if ([textField isEqual:self.passwordTF] && textField.text.length + string.length > 18)
    {
        return NO;
    }
    return YES;
}

@end
