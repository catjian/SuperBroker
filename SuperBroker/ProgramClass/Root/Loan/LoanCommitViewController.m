//
//  LoanCommitViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanCommitViewController.h"
#import "MyLoanOrderDetailViewController.h"

@interface LoanCommitViewController ()

@property (weak, nonatomic) IBOutlet UIButton *insuranceDetailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titlePictureImage;
@property (weak, nonatomic) IBOutlet UILabel *loanStateLab;
@property (weak, nonatomic) IBOutlet UILabel *prodNameLab;
@property (weak, nonatomic) IBOutlet UILabel *promotionRewardsLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *customNameLab;

@end

@implementation LoanCommitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"贷款订单提交"];
    [self setRightItemWithContentName:@"完成"];
    [self.titlePictureImage sd_setImageWithURL:[NSURL URLWithString:self.orderModel.productUrl]];
    [self.titlePictureImage.layer setCornerRadius:5];
    [self.titlePictureImage.layer setMasksToBounds:YES];
    [self.titlePictureImage.layer setBorderWidth:1];
    [self.titlePictureImage.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.prodNameLab setText:self.orderModel.productName];
    [self.promotionRewardsLab setText:[NSString stringWithFormat:@"推广奖励：%@元",self.orderModel.generalizeAmount]];;
    [self.moneyLab setText:[NSString stringWithFormat:@"期待金额：%@元",self.orderModel.expectAmount]];;
    [self.customNameLab setText:[NSString stringWithFormat:@"贷款人：%@",self.orderModel.borrowerName]];
    [self.loanStateLab setText:self.orderModel.orderStatusName];
}

- (void)backBarButtonItemAction:(UIButton *)btn
{
    UIViewController *vc ;
    for (vc in self.navigationController.viewControllers)
    {
        if ([NSStringFromClass(vc.class) isEqualToString:@"LoanViewController"])
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
        if ([NSStringFromClass(vc.class) isEqualToString:@"LoanViewController"])
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

- (IBAction)gotoRootButtonEvent:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)detailViewButtonEvent:(id)sender
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self);
    [DIF_CommonHttpAdapter
     httpRequestMyloanOrderDetailWithParameters:@{@"orderId":self.orderModel.orderId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             MyLoanOrderDetailViewController *vc = [self loadViewController:@"MyLoanOrderDetailViewController"];
             vc.orderDetail = [MyLoadOrderDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             vc.orderID = strongSelf.orderModel.orderId;
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
