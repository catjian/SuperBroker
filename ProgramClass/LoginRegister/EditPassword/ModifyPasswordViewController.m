//
//  ModifyPasswordViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation ModifyPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.phoneTF setDelegate:self];
    [self.passwordTF setDelegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self setNavTarBarTitle:@"修改密码"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event

- (IBAction)getVerifyCodeButtonEvent:(id)sender
{
    if (![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [DIF_CommonHttpAdapter
     httpRequestPasswordResetSmsCodeWithParameters:@{@"brokerPhone":self.phoneTF.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (IBAction)editPasswordButtonEvent:(id)sender
{
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
    [CommonHUD showHUDWithMessage:@"设置密码中..."];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:self.phoneTF.text forKey:@"brokerPhone"];
    [parmas setObject:self.verifyCodeTF.text forKey:@"verifyCode"];
    [parmas setObject:self.passwordTF.text forKey:@"newPassword"];
    [DIF_CommonHttpAdapter
     httpRequestPasswordResetWithParameters:parmas
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD delayShowHUDWithMessage:@"设置密码成功"];
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

- (IBAction)openPasswordSecureButtonEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self.passwordTF setSecureTextEntry:sender.selected];
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
