//
//  PresentEventViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentEventViewController.h"

@interface PresentEventViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *accountIcon;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UITextField *MoneyTF;
@property (weak, nonatomic) IBOutlet UIView *allMoneyLab;

@end

@implementation PresentEventViewController

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
    [self setNavTarBarTitle:@"我的提现"];
    [self setRightItemWithContentName:@"客服-黑"];
}

#pragma mark - Button Events
- (IBAction)selectAccountButtonEvent:(id)sender
{
    [[CommonSheetView alloc] initWithSheetTitle:@[@"支付宝",@"招商银行",@"取消"]
                                  ResponseBlock:^(NSInteger tag) {
        
    }];
}

- (IBAction)getAllMoneyButtonEvent:(id)sender
{
}

- (IBAction)commitPresentButtnEvent:(id)sender
{
    [self loadViewController:@"PresentEventResponseViewController"];
}

@end
