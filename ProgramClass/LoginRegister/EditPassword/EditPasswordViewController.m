//
//  EditPasswordViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "EditPasswordViewController.h"

@interface EditPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation EditPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"修改密码"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Event

- (IBAction)getVerifyCodeButtonEvent:(id)sender {
}

- (IBAction)editPasswordButtonEvent:(id)sender {
}

@end
