//
//  PresentEventResponseViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentEventResponseViewController.h"

@interface PresentEventResponseViewController ()

@end

@implementation PresentEventResponseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"我的提现"];
    [self setRightItemWithContentName:@"完成"];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
