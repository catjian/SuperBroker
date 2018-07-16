//
//  BuyMemeberViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BuyMemeberViewController.h"

@interface BuyMemeberViewController ()

@end

@implementation BuyMemeberViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"开通会员"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (IBAction)buyMemeberButtonEvent:(UIButton *)sender
{
    [self loadViewController:@"BuyMemberPayViewController"];
}
@end
