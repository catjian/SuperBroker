//
//  CarOrderDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderDetailViewController.h"
#import "MyOrderCarDetailModel.h"
#import "CarInsuranceBusinessViewController.h"

@interface CarOrderDetailViewController ()

@end

@implementation CarOrderDetailViewController
{
    MyOrderCarDetailModel *m_DetailModel;
    UIScrollView *m_ScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"订单详情"];
    [self setRightItemWithContentName:@"客服-黑"];
    [self httpRequestMyOrderCarDetailWithParameters];
    
    m_ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT-64)];
    [m_ScrollView setShowsVerticalScrollIndicator:NO];
    [m_ScrollView setShowsHorizontalScrollIndicator:NO];
    [m_ScrollView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self.view addSubview:m_ScrollView];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

#pragma mark - Create ContentView
- (UIView *)createCommonView
{
    CarOrderStateView *stateView = [[CarOrderStateView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (m_DetailModel.orderStatus.integerValue == 11)
    {
        [stateView.stateLab setText:[NSString stringWithFormat:@"报价：%.2f元",m_DetailModel.orderAmount.floatValue]];
        [stateView.stateLab setText:[NSString stringWithFormat:@"报价：%@元",m_DetailModel.orderAmount]];
    }
    else
    {
        for (NSDictionary *dic in m_DetailModel.orderLogs)
        {
            MyOrderCarOrderLogsModel *logsModel = [MyOrderCarOrderLogsModel mj_objectWithKeyValues:dic];
            if ([logsModel.orderStatus isEqualToString:m_DetailModel.orderStatus])
            {
                [stateView.stateLab setText:logsModel.orderStatusName];
                [stateView.stateLab setTextColor:DIF_HEXCOLOR(DIF_StateTypeColor[logsModel.orderStatusName])];
                break;
            }
        }
    }
//    [stateView.stateLab setText:[[DIF_APPDELEGATE serviceKeyValue] objectForKey:m_DetailModel.orderStatus]];
    [stateView.moneyLab setText:[NSString stringWithFormat:@"推广奖励%@元",m_DetailModel.generalizeAmount]];
    [stateView.companyIcon sd_setImageWithURL:[NSURL URLWithString:m_DetailModel.productUrl]];
    [stateView.companyName setText:m_DetailModel.productName];
    [m_ScrollView addSubview:stateView];
    DIF_WeakSelf(self)
    [stateView setBlock:^{
        DIF_StrongSelf
        CarInsuranceBusinessViewController *vc = [strongSelf loadViewController:@"CarInsuranceBusinessViewController"];
        NSMutableArray *carAllList = [NSMutableArray array];
        NSMutableArray *carSubList = [NSMutableArray array];
        for (NSDictionary *dic in strongSelf->m_DetailModel.carOrderSpecies)
        {
            if ([dic[@"speciesName"] isEqualToString:@"交强险"])
            {
                NSMutableDictionary *contentDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [contentDic setObject:@[dic[@"insuredAmount"]] forKey:@"selectList"];
                [carAllList insertObject:@{@"insuranceCarSpeciesList":@[contentDic],
                                           @"speciesName":@"交强险"} atIndex:0];
            }
            else
            {
                NSMutableDictionary *contentDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [contentDic setObject:@[dic[@"insuredAmount"]] forKey:@"selectList"];
                [carSubList addObject:contentDic];
            }
        }
        [carAllList addObject:@{@"insuranceCarSpeciesList":carSubList,
                                @"speciesName":@"商业险"}];
        vc.isCanEdit = NO;
        vc.carspeciesList = carAllList;
        vc.generalizeAmountNum = strongSelf->m_DetailModel.generalizeAmount;
    }];
    
    MyOrderCarInsuredInfoModel *carInsuredInfoModel = [MyOrderCarInsuredInfoModel mj_objectWithKeyValues:m_DetailModel.carInsuredInfo];
    CarOrderThreeLineContentView *ownerView = [[CarOrderThreeLineContentView alloc] initWithFrame:CGRectMake(0, stateView.bottom, 0, 0)];
    [ownerView.titleLab setText:@"车主信息"];
    [ownerView.contentFriLab setText:[NSString stringWithFormat:@"姓名：%@", carInsuredInfoModel.carOwnerName]];
    [ownerView.contentSecLab setText:[NSString stringWithFormat:@"身份证号：%@", carInsuredInfoModel.carOwnerCertificate]];
//    [ownerView.contentThrLab setText:[NSString stringWithFormat:@"联系方式：%@", carInsuredInfoModel.insuredPhone]];
    [m_ScrollView addSubview:ownerView];
    ownerView.height -= 24;
    
    CarInformationView *carInfoView = [[CarInformationView alloc] initWithFrame:CGRectMake(0, ownerView.bottom, 0, 0)];
    [carInfoView.titleLab setText:@"车辆信息"];
    [carInfoView.contentFriLab setText:[NSString stringWithFormat:@"车辆识别代号：%@", carInsuredInfoModel.carIdentificationCode]];
    [carInfoView.contentSecLab setText:[NSString stringWithFormat:@"发动机号：%@", carInsuredInfoModel.carEngineCode]];
    [carInfoView.contentThrLab setText:[NSString stringWithFormat:@"燃油类型：%@",carInsuredInfoModel.carOilType]];
    [carInfoView.contentFourLab setText:[NSString stringWithFormat:@"车辆注册日期：%@", [CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
                                                                                                  Formate:@"yyyy-MM-dd"]]];
    [carInfoView.userCardImage sd_setImageWithURL:[NSURL URLWithString:carInsuredInfoModel.carOwnerCertificateUrl]];
    [carInfoView.driverCardImage sd_setImageWithURL:[NSURL URLWithString:carInsuredInfoModel.carDrivingLicenseUrl]];
    [m_ScrollView addSubview:carInfoView];
    
    CarOrderThreeLineContentView *customerView = [[CarOrderThreeLineContentView alloc] initWithFrame:CGRectMake(0, carInfoView.bottom, 0, 0)];
    [customerView.titleLab setText:@"投保人信息"];
    [customerView.contentFriLab setText:[NSString stringWithFormat:@"姓名：%@", carInsuredInfoModel.insuredName]];
    [customerView.contentSecLab setHidden:YES];
//    [customerView.contentSecLab setText:[NSString stringWithFormat:@"身份证号：%@", carInsuredInfoModel.carOwnerCertificate]];
    [customerView.contentThrLab setText:[NSString stringWithFormat:@"联系方式：%@", carInsuredInfoModel.insuredPhone]];
    [m_ScrollView addSubview:customerView];
    
    if (m_DetailModel.orderStatus.integerValue == 18 ||
        m_DetailModel.orderStatus.integerValue == 14 ||
        m_DetailModel.orderStatus.integerValue == 13 ||
        m_DetailModel.orderStatus.integerValue == 17 ||
        m_DetailModel.orderStatus.integerValue == 15 ||
        m_DetailModel.orderStatus.integerValue == 16)
    {
        CarOrderDateStyleTwoView *dateTwoView = [[CarOrderDateStyleTwoView alloc] initWithFrame:CGRectMake(0, customerView.bottom, 0, 0)];
        //    dateTwoView.height -= DIF_PX(24);
        [dateTwoView.titleLab setText:[NSString stringWithFormat:@"订单编号：%@",m_DetailModel.orderCode]];
        [dateTwoView.contentFriLab setText:[NSString stringWithFormat:@"创建时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
                                                                                                  Formate:nil]]];
        [dateTwoView.contentSecLab setText:[NSString stringWithFormat:@"付款时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
                                                                                                  Formate:nil]]];
        if (m_DetailModel.orderStatus.integerValue == 18 ||
            m_DetailModel.orderStatus.integerValue == 17)
        {
            [dateTwoView.contentSecLab setText:[NSString stringWithFormat:@"取消时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
                                                                                                      Formate:nil]]];
        }
        if (m_DetailModel.orderStatus.integerValue == 15 ||
            m_DetailModel.orderStatus.integerValue == 16)
        {
            [dateTwoView.contentThrLab setText:[NSString stringWithFormat:@"结算时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
                                                                                                      Formate:nil]]];
        }
        [m_ScrollView addSubview:dateTwoView];
        return dateTwoView;
    }
    else
    {
        CarOrderDateStyleOneView *dateView = [[CarOrderDateStyleOneView alloc] initWithFrame:CGRectMake(0, customerView.bottom, 0, 0)];
        //    dateView.height -= DIF_PX(24);
        [dateView.contentFriLab setText:[NSString stringWithFormat:@"订单编号：%@",m_DetailModel.orderCode]];
        [dateView.contentSecLab setText:[NSString stringWithFormat:@"创建时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
                                                                                               Formate:nil]]];
//        [dateView.contentThrLab setText:[NSString stringWithFormat:@"创建时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:carInsuredInfoModel.carRegisterTime.integerValue/1000]
//                                                                                               Formate:@"yyyy-MM-dd"]]];
        [m_ScrollView addSubview:dateView];
        return dateView;
    }
}

//待报价
- (void)createWaitMoneyView
{
    UIView *commonView = [self createCommonView];
    
    CarOrderCancelButtonView *cancelView = [[CarOrderCancelButtonView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    [m_ScrollView addSubview:cancelView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, cancelView.bottom+55)];
    [cancelView setBlock:^{
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
                 httpRequestMyOrderCancelWithParameters:@{@"orderId":strongSelf.detailModel.orderId}
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
    }];
}

//已报价 待付款
- (void)createHadMoneyView
{
    UIView *commonView = [self createCommonView];
    
    CarOrderManagerView *managerView = [[CarOrderManagerView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    MyOrderCarManagerInfoModel *managerInfoModel = [MyOrderCarManagerInfoModel mj_objectWithKeyValues:m_DetailModel.managerInfo];
    NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc] initWithString:managerInfoModel.managerName];
    [nameAttStr attatchImage:[UIImage imageNamed:@"二维码-男"]
                  imageFrame:CGRectMake(5, 0, 8, 12)
                       Range:NSMakeRange(0, managerInfoModel.managerName.length)];
    [managerView.managerName setAttributedText:nameAttStr];
    [managerView.managerPhone setText:[NSString stringWithFormat:@"%@ %@",managerInfoModel.managerName, managerInfoModel.phone]];
    [managerView.managerQRImage sd_setImageWithURL:[NSURL URLWithString:managerInfoModel.qrCodeUrl]];
    [m_ScrollView addSubview:managerView];
    
    CarOrderTowButtonView *btnView = [[CarOrderTowButtonView alloc] initWithFrame:CGRectMake(0, managerView.bottom+55, 0, 0)];
    [btnView.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [btnView.successBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [m_ScrollView addSubview:btnView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, btnView.bottom)];
    DIF_WeakSelf(self)
    [btnView setButtonBlock:^(BOOL isSuccess) {
        DIF_StrongSelf
        if (isSuccess)
        {
            for (UIView *subView in strongSelf->m_ScrollView.subviews)
            {
                [subView removeFromSuperview];
            }
            [strongSelf performSelector:@selector(createWatiPayMoneyView) withObject:nil afterDelay:1];
        }
        else
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
                     httpRequestMyOrderCancelWithParameters:@{@"orderId":strongSelf.detailModel.orderId}
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
    }];
}

//待付款
- (void)createWatiPayMoneyView
{
    UIView *commonView = [self createCommonView];
    
    __block NSString *preCommissionAmount = @"0";
    __block CarOrderMoneyView *moneyView = [[CarOrderMoneyView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥ %.2f元",m_DetailModel.orderAmount.floatValue]];
    if (DIF_APPDELEGATE.brokerInfoModel.brokerType.integerValue != 10)
    {
        [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥ %@元",m_DetailModel.orderAmount]];
    }
    else
    {
        [moneyView hideSecondLab];
    }
    [m_ScrollView addSubview:moneyView];
    DIF_WeakSelf(self)
    [moneyView setSelectBlock:^{
        DIF_StrongSelf
        __block CarOrderCommissionInputView *inputView = [[CarOrderCommissionInputView alloc] initWithFrame:strongSelf.view.bounds];
        [inputView.carOrderMoneyLab setText:[NSString stringWithFormat:@"车险保单金额： %.2f元",strongSelf->m_DetailModel.orderAmount.floatValue]];
        [inputView.carOrderMoneyLab setText:[NSString stringWithFormat:@"车险保单金额： %@元",strongSelf->m_DetailModel.orderAmount]];
        [inputView.allCommissionLab setText:[NSString stringWithFormat:@"(消费券余额%.2f元)",[DIF_APPDELEGATE.mybrokeramount[@"vouchers"] floatValue]]];
        [inputView.allCommissionLab setText:[NSString stringWithFormat:@"(消费券余额%@元)",DIF_APPDELEGATE.mybrokeramount[@"vouchers"]]];
        [strongSelf.view addSubview:inputView];
        [inputView setBlock:^(NSString *money){
            [inputView removeFromSuperview];
            if (money)
            {
                preCommissionAmount = money;
                [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%.2f元",money.floatValue]];
                [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%@元",money]];
                [moneyView.contentSecLab setTextColor:DIF_HEXCOLOR(@"ff5000")];
            }
        }];
    }];
    
    
    CarOrderMoneyButtonView *btnView = [[CarOrderMoneyButtonView alloc] initWithFrame:CGRectMake(0, moneyView.bottom, 0, 0)];
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f",m_DetailModel.orderAmount.floatValue];
    moneyStr = [NSString stringWithFormat:@"￥%@",m_DetailModel.orderAmount];
    NSMutableAttributedString *attMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计： %@元",moneyStr]];
    [attMoneyStr FontAttributeNameWithFont:DIF_UIFONTOFSIZE(16) Range:[attMoneyStr.string rangeOfString:moneyStr]];
    [attMoneyStr ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"017aff") Range:[attMoneyStr.string rangeOfString:moneyStr]];
    [btnView.moneyLab setAttributedText:attMoneyStr];
    [btnView.successBtn setTitle:@"提交付款" forState:UIControlStateNormal];
    [m_ScrollView addSubview:btnView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, btnView.bottom)];
    [btnView setButtonBlock:^{
        DIF_StrongSelf
        [CommonHUD showHUD];
        [DIF_CommonHttpAdapter
         httpRequestMyOrderCarPayWithParameters:@{@"orderId":strongSelf->m_DetailModel.orderId,
                                                  @"preCommissionAmount":preCommissionAmount.length==0?@"0":preCommissionAmount}
         ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
             DIF_StrongSelf
             if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
             {
                 [CommonHUD hideHUD];
                 CarOrderWaitReviewViewController *vc =[strongSelf loadViewController:@"CarOrderWaitReviewViewController"];
                 vc.detailModel = strongSelf->m_DetailModel;
             }
             else
             {
                 [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
             }
         } FailedBlcok:^(NSError *error) {
             [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
         }];
    }];
}

//结算中
- (void)createPayMoneyView
{
    UIView *commonView = [self createCommonView];
    
    CarOrderManagerView *managerView = [[CarOrderManagerView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    MyOrderCarManagerInfoModel *managerInfoModel = [MyOrderCarManagerInfoModel mj_objectWithKeyValues:m_DetailModel.managerInfo];
    NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc] initWithString:managerInfoModel.managerName];
    [nameAttStr attatchImage:[UIImage imageNamed:@"二维码-男"]
                  imageFrame:CGRectMake(5, 0, 8, 12)
                       Range:NSMakeRange(0, managerInfoModel.managerName.length)];
    [managerView.managerName setAttributedText:nameAttStr];
    [managerView.managerPhone setText:[NSString stringWithFormat:@"%@ %@",managerInfoModel.managerName, managerInfoModel.phone]];
    [managerView.managerQRImage sd_setImageWithURL:[NSURL URLWithString:managerInfoModel.qrCodeUrl]];
    [m_ScrollView addSubview:managerView];
    
    CarOrderMoneyView *moneyView = [[CarOrderMoneyView alloc] initWithFrame:CGRectMake(0, managerView.bottom, 0, 0)];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.orderAmount.floatValue]];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.orderAmount]];
    if (DIF_APPDELEGATE.brokerInfoModel.brokerType.integerValue != 10)
    {
        [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.preCommissionAmount.floatValue]];
        if ([m_DetailModel.preCommissionAmount isEqualToString:@"0"])
        {
            [moneyView.contentSecLab setText:@"未使用消费券"];
        }
        else
        {
            [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.preCommissionAmount]];
        }
    }
    else
    {
        [moneyView hideSecondLab];
    }
    [m_ScrollView addSubview:moneyView];
    
    CarOrderMoneyButtonView *btnView = [[CarOrderMoneyButtonView alloc] initWithFrame:CGRectMake(0, moneyView.bottom, 0, 0)];
    [btnView.moneyLab setTextAlignment:NSTextAlignmentRight];
    [btnView setShowButton:NO];
    [m_ScrollView addSubview:btnView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, btnView.bottom)];
}

//已完成
- (void)createFinishOrderView
{
    UIView *commonView = [self createCommonView];
    CarOrderManagerView *managerView = [[CarOrderManagerView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    MyOrderCarManagerInfoModel *managerInfoModel = [MyOrderCarManagerInfoModel mj_objectWithKeyValues:m_DetailModel.managerInfo];
    NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc] initWithString:managerInfoModel.managerName];
    [nameAttStr attatchImage:[UIImage imageNamed:@"二维码-男"]
                  imageFrame:CGRectMake(5, 0, 8, 12)
                       Range:NSMakeRange(0, managerInfoModel.managerName.length)];
    [managerView.managerName setAttributedText:nameAttStr];
    [managerView.managerPhone setText:[NSString stringWithFormat:@"%@ %@",managerInfoModel.managerName, managerInfoModel.phone]];
    [managerView.managerQRImage sd_setImageWithURL:[NSURL URLWithString:managerInfoModel.qrCodeUrl]];
    [m_ScrollView addSubview:managerView];
    
    CarOrderMoneyView *moneyView = [[CarOrderMoneyView alloc] initWithFrame:CGRectMake(0, managerView.bottom, 0, 0)];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.orderAmount.floatValue]];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.orderAmount]];
    if (DIF_APPDELEGATE.brokerInfoModel.brokerType.integerValue != 10)
    {
        [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.preCommissionAmount.floatValue]];
        if ([m_DetailModel.preCommissionAmount isEqualToString:@"0"])
        {
            [moneyView.contentSecLab setText:@"未使用消费券"];
        }
        else
        {
            [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.preCommissionAmount]];
        }
    }
    else
    {
        [moneyView hideSecondLab];
    }
    [m_ScrollView addSubview:moneyView];
    
    CarOrderMoneyButtonView *btnView = [[CarOrderMoneyButtonView alloc] initWithFrame:CGRectMake(0, moneyView.bottom, 0, 0)];
    [btnView.moneyLab setTextAlignment:NSTextAlignmentRight];
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f",m_DetailModel.orderAmount.floatValue];
    moneyStr = [NSString stringWithFormat:@"￥%@",m_DetailModel.orderAmount];
    NSMutableAttributedString *attMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计： %@元",moneyStr]];
    [attMoneyStr FontAttributeNameWithFont:DIF_UIFONTOFSIZE(16) Range:[attMoneyStr.string rangeOfString:moneyStr]];
    [attMoneyStr ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"017aff") Range:[attMoneyStr.string rangeOfString:moneyStr]];
    [btnView.moneyLab setAttributedText:attMoneyStr];
    [btnView setShowButton:NO];
    [m_ScrollView addSubview:btnView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, btnView.bottom)];
}

//已取消
- (void)createCancelOrderView
{
    UIView *commonView = [self createCommonView];
    
    if (m_DetailModel.orderAmount.length > 0)
    {
        CarOrderMoneyView *moneyView = [[CarOrderMoneyView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
        [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.orderAmount.floatValue]];
        [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.orderAmount]];
        if (m_DetailModel.preCommissionAmount.length > 0)
        {
            [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.preCommissionAmount.floatValue]];
            if ([m_DetailModel.preCommissionAmount isEqualToString:@"0"])
            {
                [moneyView.contentSecLab setText:@"未使用消费券"];
            }
            else
            {
                [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.preCommissionAmount]];
            }
        }
        else
        {
            [moneyView.contentSecLab setHidden:YES];
        }
        [m_ScrollView addSubview:moneyView];
        commonView = moneyView;
    }
    
    CarOrderCancelButtonView *cancelView = [[CarOrderCancelButtonView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    [cancelView.titleLab setText:@"取消的订单，经后台审核后将退还未使用的消费券。"];
    [cancelView.cancelBtn setHidden:YES];
    [m_ScrollView addSubview:cancelView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, cancelView.bottom)];
}

//待审核
- (void)createWaitReviewView
{
    UIView *commonView = [self createCommonView];
    CarOrderManagerView *managerView = [[CarOrderManagerView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    MyOrderCarManagerInfoModel *managerInfoModel = [MyOrderCarManagerInfoModel mj_objectWithKeyValues:m_DetailModel.managerInfo];
    NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc] initWithString:managerInfoModel.managerName];
    [nameAttStr attatchImage:[UIImage imageNamed:@"二维码-男"]
                  imageFrame:CGRectMake(5, 0, 8, 12)
                       Range:NSMakeRange(0, managerInfoModel.managerName.length)];
    [managerView.managerName setAttributedText:nameAttStr];
    [managerView.managerPhone setText:[NSString stringWithFormat:@"%@ %@",managerInfoModel.managerName, managerInfoModel.phone]];
    [managerView.managerQRImage sd_setImageWithURL:[NSURL URLWithString:managerInfoModel.qrCodeUrl]];
    [m_ScrollView addSubview:managerView];
    
    CarOrderMoneyView *moneyView = [[CarOrderMoneyView alloc] initWithFrame:CGRectMake(0, managerView.bottom, 0, 0)];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.orderAmount.floatValue]];
    [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.orderAmount]];
    if (DIF_APPDELEGATE.brokerInfoModel.brokerType.integerValue != 10)
    {
        [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.preCommissionAmount.floatValue]];
        if ([m_DetailModel.preCommissionAmount isEqualToString:@"0"])
        {
            [moneyView.contentSecLab setText:@"未使用消费券"];
        }
        else
        {
            [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.preCommissionAmount]];
        }
    }
    else
    {
        [moneyView hideSecondLab];
    }
    [m_ScrollView addSubview:moneyView];
    
    CarOrderMoneyButtonView *btnView = [[CarOrderMoneyButtonView alloc] initWithFrame:CGRectMake(0, moneyView.bottom, 0, 0)];
    [btnView.moneyLab setTextAlignment:NSTextAlignmentRight];
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f",m_DetailModel.orderAmount.floatValue];
    moneyStr = [NSString stringWithFormat:@"￥%@",m_DetailModel.orderAmount];
    NSMutableAttributedString *attMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计： %@元",moneyStr]];
    [attMoneyStr FontAttributeNameWithFont:DIF_UIFONTOFSIZE(16) Range:[attMoneyStr.string rangeOfString:moneyStr]];
    [attMoneyStr ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"017aff") Range:[attMoneyStr.string rangeOfString:moneyStr]];
    [btnView.moneyLab setAttributedText:attMoneyStr];
    [btnView setShowButton:NO];
    [m_ScrollView addSubview:btnView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, btnView.bottom)];
}

//已关闭
- (void)createCloseOrderView
{
    UIView *commonView = [self createCommonView];
    
    
    if (m_DetailModel.orderAmount.length > 0)
    {
        CarOrderMoneyView *moneyView = [[CarOrderMoneyView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
        [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.orderAmount.floatValue]];
        [moneyView.contentFriLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.orderAmount]];
        if (m_DetailModel.preCommissionAmount.length > 0)
        {
            [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%.2f元",m_DetailModel.preCommissionAmount.floatValue]];
            if ([m_DetailModel.preCommissionAmount isEqualToString:@"0"])
            {
                [moneyView.contentSecLab setText:@"未使用消费券"];
            }
            else
            {
                [moneyView.contentSecLab setText:[NSString stringWithFormat:@"￥%@元",m_DetailModel.preCommissionAmount]];
            }
        }
        else
        {
            [moneyView.contentSecLab setHidden:YES];
        }
        [m_ScrollView addSubview:moneyView];
        commonView = moneyView;
    }
    
    CarOrderCancelButtonView *cancelView = [[CarOrderCancelButtonView alloc] initWithFrame:CGRectMake(0, commonView.bottom, 0, 0)];
    [cancelView.titleLab setText:@"取消的订单，经后台审核后将退还未使用的消费券。"];
    [cancelView.cancelBtn setHidden:YES];
    [m_ScrollView addSubview:cancelView];
    [m_ScrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, cancelView.bottom+55)];
}

#pragma mark - HttpRequest

- (void)httpRequestMyOrderCarDetailWithParameters
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyOrderCarDetailWithParameters:@{@"orderId":self.detailModel.orderId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD hideHUD];
             strongSelf->m_DetailModel = [MyOrderCarDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             switch (strongSelf->m_DetailModel.orderStatus.integerValue)
             {
                 case 11:
                     [strongSelf createHadMoneyView];
                     break;
                 case 12:
                     [strongSelf createWaitMoneyView];
                     break;
                 case 13:
                     [strongSelf createWaitReviewView];
                     break;
                 case 15:
                     [strongSelf createFinishOrderView];
                     break;
                 case 16:
                     [strongSelf createPayMoneyView];
                     break;
                 case 17:
                     [strongSelf createCancelOrderView];
                     break;
                 case 18:
                     [strongSelf createCloseOrderView];
                     break;
                 default:
                     break;
             }
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
