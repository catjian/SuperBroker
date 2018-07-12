//
//  RegisterViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *openSecureBtn;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event

- (IBAction)getVerifyCodeButtonEvent:(id)sender
{
}

- (IBAction)openPasswordSecureButtonEvent:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [sender setTitle:sender.selected?@"开":@"关" forState:UIControlStateNormal];
    [self.passwordTF setSecureTextEntry:sender.selected];
}

- (IBAction)registerButtonEvent:(id)sender
{
}

- (IBAction)gotoLoginButtonEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
