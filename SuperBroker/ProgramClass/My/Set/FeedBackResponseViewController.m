//
//  FeedBackResponseViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "FeedBackResponseViewController.h"

@interface FeedBackResponseViewController ()

@end

@implementation FeedBackResponseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"意见反馈"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)gotoRootViewControllerEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
