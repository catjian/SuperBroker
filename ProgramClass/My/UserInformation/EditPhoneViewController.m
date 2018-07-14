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
    [self setRightItemWithContentName:@"客服"];
}

- (IBAction)getVerfifyEditPhoneButtonEvent:(UIButton *)sender
{
    [self.view endEditing:YES];
}

- (IBAction)commitEditPhoneButtonEvent:(id)sender
{
    [self.view endEditing:YES];
}

@end
