//
//  InsuranceOrderWaitViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceOrderWaitViewController.h"

@interface InsuranceOrderWaitViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *insIcon;
@property (weak, nonatomic) IBOutlet UILabel *insName;
@property (weak, nonatomic) IBOutlet UILabel *insDateLab;

@property (weak, nonatomic) IBOutlet UILabel *generalizeAmount;

@end

@implementation InsuranceOrderWaitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"保险订单提交"];
    [self setRightItemWithContentName:@"客服-黑"];    
//    [self.promotionRewardsLab setText:[NSString stringWithFormat:@"推广奖励：%@元",m_DetailModel.generalizeAmount]];
}

- (IBAction)gohomeButtonEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
