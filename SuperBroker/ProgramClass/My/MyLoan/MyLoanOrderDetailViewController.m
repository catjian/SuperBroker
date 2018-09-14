//
//  MyLoanOrderDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/5.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyLoanOrderDetailViewController.h"

@interface MyLoanOrderDetailViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *gemAmont;

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLab;
@property (weak, nonatomic) IBOutlet UILabel *productSummeyLab;

@property (weak, nonatomic) IBOutlet UILabel *loanTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *expAmountlab;
@property (weak, nonatomic) IBOutlet UILabel *customNamLab;
@property (weak, nonatomic) IBOutlet UILabel *customPhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *customCardIDLab;

@property (weak, nonatomic) IBOutlet UIView *remarkBGView;
@property (weak, nonatomic) IBOutlet UITextField *remarkLab;

@property (weak, nonatomic) IBOutlet UIImageView *customCardIDImage;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIView *orderAmountBG;
@property (weak, nonatomic) IBOutlet UILabel *orderAmontLab;
@property (weak, nonatomic) IBOutlet UILabel *commissionAmountlab;
@property (weak, nonatomic) IBOutlet UIView *productImageBG;

@end

@implementation MyLoanOrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavTarBarTitle:@"贷款订单详情"];
    [self setRightItemWithContentName:@"客服-黑"];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.remarkBGView.layer.cornerRadius == 0)
    {
        [self.scrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.bottomView.bottom)];
        [self.scrollView setDelegate:self];
        [self.remarkBGView.layer setCornerRadius:5];
        [self.remarkBGView.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.remarkBGView.layer setBorderWidth:1];
        
        [self.orderAmountBG setHeight:0];
        [self.orderAmountBG setHidden:YES];
        
        MyLoadInsuranceOrderModel *insuranceOrder = [MyLoadInsuranceOrderModel mj_objectWithKeyValues:self.orderDetail.insuranceOrder];
        MyLoadInsuranceLoanBorrowerModel *insuranceLoanBorrower = [MyLoadInsuranceLoanBorrowerModel mj_objectWithKeyValues:self.orderDetail.insuranceLoanBorrower];
        MyLoadInsuranceLoanProductModel *insuranceLoanProduct = [MyLoadInsuranceLoanProductModel mj_objectWithKeyValues:self.orderDetail.insuranceLoanProduct];
        if (insuranceOrder.orderStatus.integerValue==15)
        {
            [self.orderAmountBG setHidden:NO];
            [self.orderAmountBG setHeight:47];
            [self.orderAmontLab setText:[NSString stringWithFormat:@"贷款金额%@元", insuranceOrder.orderAmount]];
            [self.commissionAmountlab setText:[NSString stringWithFormat:@"保证金%@元",insuranceOrder.commissionAmount]];
        }
        else
        {
            [self.orderAmountBG setHeight:0];
            [self.orderAmountBG setHidden:YES];
            [self.productImageBG setTop:self.orderAmountBG.bottom];
            UIView *subView = [self.view viewWithTag:990];
            [subView setTop:self.productImageBG.bottom];
            for (int i = 991; i <= 1006; i++)
            {
                UIView *subLevView = [self.view viewWithTag:i-1];
                UIView *subView = [self.view viewWithTag:i];
                [subView setTop:subLevView.bottom];
            }
        }
        
        for (NSDictionary *dic in insuranceOrder.orderLogs)
        {
            MyOrderInsuranceDetailOrderLogsModel *orderLog = [MyOrderInsuranceDetailOrderLogsModel mj_objectWithKeyValues:dic];
            if ([orderLog.orderStatus isEqualToString:insuranceOrder.orderStatus])
            {
                [self.statusLab setText:orderLog.orderStatusName];
                if (insuranceOrder.orderStatus.integerValue==15)
                {
                    [self.statusLab setTextColor:DIF_HEXCOLOR(@"017aff")];
                }
                break;
            }
        }
        [self.gemAmont setText:[NSString stringWithFormat:@"推广奖励%@元",insuranceOrder.generalizeAmount]];
        
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:insuranceLoanProduct.productUrl]];
        [self.productImageView.layer setCornerRadius:5];
        [self.productImageView.layer setMasksToBounds:YES];
        [self.productImageView.layer setBorderWidth:1];
        [self.productImageView.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.productNameLab setText:insuranceLoanProduct.productName];
        [self.productSummeyLab setText:insuranceLoanProduct.summary];
        
        [self.loanTypeLab setText:insuranceLoanBorrower.loanTypeName];
        [self.expAmountlab setText:[insuranceLoanBorrower.expectAmount stringByAppendingString:@"元"]];
        [self.customNamLab setText:insuranceLoanBorrower.borrowerName];
        [self.customPhoneLab setText:insuranceLoanBorrower.borrowerPhone];
        [self.customCardIDLab setText:insuranceLoanBorrower.identityCard];
        [self.remarkLab setText:insuranceLoanBorrower.remark];
        [self.customCardIDImage sd_setImageWithURL:[NSURL URLWithString:insuranceLoanBorrower.borrowerCertificateUrl]];
        
        if (insuranceOrder.orderStatus.integerValue == 13)
        {
            [self.cancelBtn setHidden:NO];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    MyLoadInsuranceOrderModel *insuranceOrder = [MyLoadInsuranceOrderModel mj_objectWithKeyValues:self.orderDetail.insuranceOrder];
    if (insuranceOrder.orderStatus.integerValue!=15)
    {
        [self.orderAmountBG setHeight:0];
        [self.orderAmountBG setHidden:YES];
        [self.productImageBG setTop:self.orderAmountBG.bottom];
        UIView *subView = [self.view viewWithTag:990];
        [subView setTop:self.productImageBG.bottom];
        for (int i = 991; i <= 1006; i++)
        {
            UIView *subLevView = [self.view viewWithTag:i-1];
            UIView *subView = [self.view viewWithTag:i];
            [subView setTop:subLevView.bottom];
        }
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)cancelLoanOrder:(id)sender
{
    CancelCommitOrderView *cancelView = [[CancelCommitOrderView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)];
    [DIF_APPDELEGATE.window addSubview:cancelView];
    [cancelView show];
    DIF_WeakSelf(self)
    [cancelView setBlock:^(BOOL isSuccess) {
        if (isSuccess)
        {
            [CommonHUD showHUDWithMessage:@"取消订单中..."];
            DIF_StrongSelf
            [DIF_CommonHttpAdapter
             httpRequestMyloanCancelOrderWithParameters:@{@"orderId":strongSelf.orderID}
             ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                 DIF_StrongSelf
                 if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
                 {
                     [CommonHUD delayShowHUDWithMessage:@"取消订单成功"];
                     [strongSelf.navigationController popToRootViewControllerAnimated:YES];
                 }
                 else
                 {
                     [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
                 }
             } FailedBlcok:^(NSError *error) {
                 [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
             }];
        }
    }];
}

@end
