//
//  BuyMemberSuccessViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BuyMemberSuccessViewController.h"

@interface BuyMemberSuccessViewController ()

@end

@implementation BuyMemberSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"开通会员"];
    [self setRightItemWithContentName:@"完成"];
}

- (IBAction)gotoRootViewControllerEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
