//
//  CarInsuranceCommitViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/26.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceCommitViewController.h"

@interface CarInsuranceCommitViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLab;

@end

@implementation CarInsuranceCommitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"车险服务"];
}

- (IBAction)gohomeButtonEvent:(id)sender
{
}
@end
