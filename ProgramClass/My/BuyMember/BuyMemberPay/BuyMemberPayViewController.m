//
//  BuyMemberPayViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BuyMemberPayViewController.h"

@interface BuyMemberPayViewController ()

@property (weak, nonatomic) IBOutlet UIButton *selectALPay;
@property (weak, nonatomic) IBOutlet UIButton *selectUB;

@end

@implementation BuyMemberPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"开通会员"];
    [self setRightItemWithContentName:@"客服"];
}

- (IBAction)selectPayTypeButtonEvent:(UIButton *)sender
{
    if (!sender.selected)
    {
        sender.selected = YES;
        if ([sender isEqual:self.selectUB])
        {
            self.selectALPay.selected = NO;
        }
        else
        {
            self.selectUB.selected = NO;
        }
    }
}

- (IBAction)successPayMoneyButtonEvent:(id)sender
{
    [self loadViewController:@"BuyMemberSuccessViewController"];
}
@end
