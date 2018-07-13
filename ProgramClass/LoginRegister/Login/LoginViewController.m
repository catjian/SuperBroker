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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event
- (IBAction)loginButtonEvent:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
