//
//  MyOrderDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "MyOrderInsuranceDetailModel.h"

@interface MyOrderDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *generalizeAmountLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *insState;
@property (weak, nonatomic) IBOutlet UIImageView *insIcon;
@property (weak, nonatomic) IBOutlet UILabel *insNameLab;
@property (weak, nonatomic) IBOutlet UILabel *insDateLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredNameLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredCardIDLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredRelevanceLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredPhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredEmailLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *createDateLab;
@property (weak, nonatomic) IBOutlet UILabel *managerPhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *payDateLab;
@property (weak, nonatomic) IBOutlet UILabel *endOrderDateLab;
@property (weak, nonatomic) IBOutlet UIImageView *managerIcon;
@property (weak, nonatomic) IBOutlet UILabel *managerNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *managerQRImage;
@property (weak, nonatomic) IBOutlet UIView *managerDetailView;
@property (weak, nonatomic) IBOutlet UIView *orderDateView;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *space1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@end

@implementation MyOrderDetailViewController
{
    MyOrderInsuranceDetailModel *m_DetailModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"订单详情"];
    [self setRightItemWithContentName:@"客服-黑"];
    [self httpRequestMyOrderInsuranceDetailWithParameters];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.managerDetailView.bottom)];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (void)hiddenEndOrderDateLab
{
    if (self.endOrderDateLab.alpha == 1)
    {
        [self.endOrderDateLab setAlpha:0];
//        self.orderDateView.height -= 20;
        self.line1.top -= 22;
        self.space1.top -= 22;
        self.line2.top -= 22;
        self.managerDetailView.top -= 22;
    }
    else
    {
        [self.endOrderDateLab setAlpha:1];
//        self.orderDateView.height += 20;
        self.line1.top += 22;
        self.space1.top += 22;
        self.line2.top += 22;
        self.managerDetailView.top += 22;
    }
}

- (void)reloadViewContent
{
    for (NSDictionary *dic in m_DetailModel.orderLogs)
    {
        MyOrderInsuranceDetailOrderLogsModel *logsModel = [MyOrderInsuranceDetailOrderLogsModel mj_objectWithKeyValues:dic];
        if ([logsModel.orderStatus isEqualToString:m_DetailModel.orderStatus])
        {
            [self.insState setText:logsModel.orderStatusName];
            [self.insState setTextColor:DIF_HEXCOLOR(DIF_StateTypeColor[logsModel.orderStatusName])];
        }
        if ([logsModel.orderStatus isEqualToString:@"11"])
        {
            [self.createDateLab setText:[NSString stringWithFormat:@"创建时间：%@",
                                           [CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:logsModel.createTime.integerValue/1000]
                                                            Formate:nil]]];
//            [self.createDateLab setText:[NSString stringWithFormat:@"%@：%@",logsModel.statusTimeName,[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_DetailModel.createTime.integerValue/1000]
//                                                                                                                      Formate:nil]]];
        }
        if ([logsModel.orderStatus isEqualToString:@"13"])
        {
            [self.payDateLab setText:[NSString stringWithFormat:@"付款时间：%@",
                                           [CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:logsModel.createTime.integerValue/1000]
                                                            Formate:nil]]];
//            [self.payDateLab setText:[NSString stringWithFormat:@"%@：%@",logsModel.statusTimeName,[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_DetailModel.createTime.integerValue/1000]
//                                                                                                                   Formate:nil]]];
        }
        if ([logsModel.orderStatus isEqualToString:@"15"])
        {
            [self.endOrderDateLab setText:[NSString stringWithFormat:@"结算时间：%@",
                                           [CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:logsModel.createTime.integerValue/1000]
                                                            Formate:nil]]];
//            [self.endOrderDateLab setText:[NSString stringWithFormat:@"%@：%@",logsModel.statusTimeName,[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_DetailModel.createTime.integerValue/1000]
//                                                                                                                        Formate:nil]]];
        }
        
    }
    MyOrderInsuranceDetailInsuredInfoModel *insuredInfoModel = [MyOrderInsuranceDetailInsuredInfoModel mj_objectWithKeyValues:m_DetailModel.insuredInfo];
    MyOrderInsuranceDetailManagerInfoModel *managerInfoModel = [MyOrderInsuranceDetailManagerInfoModel mj_objectWithKeyValues:m_DetailModel.managerInfo];
    [self.generalizeAmountLab setText:[NSString stringWithFormat:@"推广奖励%@元", m_DetailModel.generalizeAmount]];
    [self.insIcon sd_setImageWithURL:[NSURL URLWithString:m_DetailModel.productUrl]];
    [self.insNameLab setText:m_DetailModel.productName];
    [self.insDateLab setText:[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_DetailModel.createTime.integerValue/1000]
                                              Formate:@"yyyy-MM-dd"]];
    [self.insuredNameLab setText:[NSString stringWithFormat:@"姓名：%@",insuredInfoModel.insuredName]];
    [self.insuredCardIDLab setText:[NSString stringWithFormat:@"身份证号：%@",insuredInfoModel.certificate]];
    [self.insuredRelevanceLab setText:[NSString stringWithFormat:@"投保关系：%@",insuredInfoModel.insuredRelation]];
    [self.insuredPhoneLab setText:[NSString stringWithFormat:@"联系方式：%@",insuredInfoModel.insuredPhone]];
    [self.insuredEmailLab setText:[NSString stringWithFormat:@"邮箱：%@",insuredInfoModel.insuredEmail]];
    [self.orderNumLab setText:[NSString stringWithFormat:@"订单编号：%@",m_DetailModel.orderCode]];
    NSMutableAttributedString *nameAttStr = [[NSMutableAttributedString alloc] initWithString:managerInfoModel.managerName];
    [nameAttStr attatchImage:[UIImage imageNamed:@"二维码-男"]
                  imageFrame:CGRectMake(5, 0, 8, 12)
                       Range:NSMakeRange(0, managerInfoModel.managerName.length)];
    [self.managerNameLab setAttributedText:nameAttStr];
    [self.managerPhoneLab setText:[NSString stringWithFormat:@"%@ %@",managerInfoModel.managerName, managerInfoModel.phone]];
    [self.managerQRImage sd_setImageWithURL:[NSURL URLWithString:managerInfoModel.qrCodeUrl]];
    [self.orderDateView setHeight:72];
    self.line1.top = self.orderDateView.bottom;
    self.space1.top = self.line1.bottom;
    self.line2.top = self.space1.bottom;
    self.managerDetailView.top = self.line2.bottom;
    if (self.endOrderDateLab.text.length <= 0)
    {
        self.orderDateView.height -= 24;
        [self.endOrderDateLab setHidden:YES];
    }
    if (self.payDateLab.text.length <= 0)
    {
        self.orderDateView.height -= 24;
        [self.payDateLab setHidden:YES];
    }
    self.line1.top = self.orderDateView.bottom;
    self.space1.top = self.line1.bottom;
    self.line2.top = self.space1.bottom;
    self.managerDetailView.top = self.line2.bottom;
}

#pragma mark - HttpRequest

- (void)httpRequestMyOrderInsuranceDetailWithParameters
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyOrderInsuranceDetailWithParameters:@{@"orderId":self.detailModel.orderId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {        
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD hideHUD];
             strongSelf->m_DetailModel = [MyOrderInsuranceDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             [strongSelf performSelector:@selector(reloadViewContent) withObject:nil afterDelay:0.5];
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
