//
//  SMSLoginViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SMSLoginViewController.h"

@interface SMSLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;

@end

@implementation SMSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
}

#pragma mark - Button Event

- (IBAction)getVerifyButtonEvent:(id)sender {
}

- (IBAction)SMSLoginButtonEvent:(id)sender {
}

- (IBAction)gotoNormalLoginButtonEvent:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gotoRegisterButtonEvent:(id)sender
{
    [self loadViewController:@"RegisterViewController"];
}
@end
