//
//  EditPhoneViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "EditPhoneViewController.h"

@interface EditPhoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UITextField *oldPhoneTF;

@end

@implementation EditPhoneViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"手机号修改"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)getVerfifyEditPhoneButtonEvent:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入正确的新手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if ([self.phoneTF.text isEqualToString:self.oldPhoneTF.text])
    {
        [self.view makeToast:@"新手机号码不能与旧手机号码一致"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    [DIF_CommonHttpAdapter
     httpRequestBrokerinfoSmsCodeWithParameters:@{@"brokerPhone":self.phoneTF.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (IBAction)commitEditPhoneButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    if (![CommonVerify isMobileNumber:self.oldPhoneTF.text])
    {
        [self.view makeToast:@"请输入旧手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入新手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if ([self.phoneTF.text isEqualToString:self.oldPhoneTF.text])
    {
        [self.view makeToast:@"新手机号码不能与旧手机号码一致"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.verifyTF.text.length < 1)
    {
        [self.view makeToast:@"请输入验证码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestBrokerinfoPhoneWithParameters:@{@"brokerPhone":self.oldPhoneTF.text,//[[NSUserDefaults standardUserDefaults] stringForKey:DIF_Loaction_Save_UserId],
                                                @"newBrokerPhone":self.phoneTF.text,
                                                @"code":self.verifyTF.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf.navigationController popViewControllerAnimated:YES];
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
