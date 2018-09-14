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
    [self.orderIdLab setText:[NSString stringWithFormat:@"您的订单号：%@",self.carOrderId]];;
}

- (void)backBarButtonItemAction:(UIButton *)btn
{    
    UIViewController *vc ;
    for (vc in self.navigationController.viewControllers)
    {
        if ([NSStringFromClass(vc.class) isEqualToString:@"CarInsuranceViewController"])
        {
            break;
        }
    }
    if (vc)
    {
        [self.navigationController popToViewController:vc animated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)gohomeButtonEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
