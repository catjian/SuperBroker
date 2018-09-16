//
//  InsuranceCommitViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceCommitViewController.h"
#import "InsuranceOrderCommitViewController.h"

@interface InsuranceCommitViewController ()

@property (weak, nonatomic) IBOutlet UIButton *insuranceDetailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titlePictureImage;
@property (weak, nonatomic) IBOutlet UILabel *insuranceStateLab;
@property (weak, nonatomic) IBOutlet UILabel *prodNameLab;
@property (weak, nonatomic) IBOutlet UILabel *promotionRewardsLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@end

@implementation InsuranceCommitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"保险订单提交"];
    [self setRightItemWithContentName:@"完成"];
    [self.titlePictureImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.productUrl]];
    [self.prodNameLab setText:self.detailModel.productName];
    [self.dateLab setText:[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:self.detailModel.createTime.integerValue/1000]
                                           Formate:@"yyyy-MM-dd HH:mm"]];
    [self.promotionRewardsLab setText:[NSString stringWithFormat:@"推广奖励：%@元",self.detailModel.promotionRewards]];
    [self.insuranceStateLab setText:self.detailModel.orderStatusName];
}

- (void)backBarButtonItemAction:(UIButton *)btn
{
    UIViewController *vc ;
    for (vc in self.navigationController.viewControllers)
    {
        if ([NSStringFromClass(vc.class) isEqualToString:@"InsuranceViewController"])
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

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    UIViewController *vc ;
    for (vc in self.navigationController.viewControllers)
    {
        if ([NSStringFromClass(vc.class) isEqualToString:@"InsuranceViewController"])
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

- (IBAction)insuranceDetailButtonEvent:(id)sender
{
    InsuranceOrderCommitViewController *vc = [self loadViewController:@"InsuranceOrderCommitViewController"];
    vc.detailModel = self.detailModel;
    vc.customInfo = self.customInfo;
}

- (IBAction)gotoRootButtonEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
