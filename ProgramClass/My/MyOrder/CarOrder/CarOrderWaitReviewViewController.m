//
//  CarOrderWaitReviewViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderWaitReviewViewController.h"

@interface CarOrderWaitReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLab;
@property (weak, nonatomic) IBOutlet UILabel *managerPhone;
@property (weak, nonatomic) IBOutlet UILabel *managerName;
@property (weak, nonatomic) IBOutlet UIImageView *managerIcon;
@property (weak, nonatomic) IBOutlet UIImageView *managerQRImage;

@end

@implementation CarOrderWaitReviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"车险订单"];
    [self setRightItemWithContentName:@"完成"];
}

@end
