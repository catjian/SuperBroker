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
    
    [self.orderIdLab setText:[NSString stringWithFormat:@"您的订单号：%@",self.detailModel.orderCode]];
    MyOrderCarManagerInfoModel *managerInfoModel = [MyOrderCarManagerInfoModel mj_objectWithKeyValues:self.detailModel.managerInfo];
    NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc] initWithString:managerInfoModel.managerName];
    [nameAttStr attatchImage:[UIImage imageNamed:@"二维码-男"]
                  imageFrame:CGRectMake(5, 0, 8, 12)
                       Range:NSMakeRange(0, managerInfoModel.managerName.length)];
    [self.managerName setAttributedText:nameAttStr];
    [self.managerPhone setText:[NSString stringWithFormat:@"%@ %@",managerInfoModel.managerName, managerInfoModel.phone]];
    [self.managerQRImage sd_setImageWithURL:[NSURL URLWithString:managerInfoModel.qrCodeUrl]];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self backBarButtonItemAction:nil];
}

- (void)backBarButtonItemAction:(UIButton *)btn
{
    UIViewController *vc ;
    for (vc in self.navigationController.viewControllers)
    {
        if ([NSStringFromClass(vc.class) isEqualToString:@"MyOrderListViewController"])
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

@end
