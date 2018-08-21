//
//  BuyMemberPayViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BuyMemberPayViewController.h"
#import "OpenAlipaysViewController.h"

@interface BuyMemberPayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cardTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardMoney;
@property (weak, nonatomic) IBOutlet UITextView *cardDetail;
@property (weak, nonatomic) IBOutlet UIImageView *cardBack;
@property (weak, nonatomic) IBOutlet UIButton *selectALPay;
@property (weak, nonatomic) IBOutlet UIButton *selectUB;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyBtn;

@end

@implementation BuyMemberPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"开通会员"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *strHtml = self.detailModel.businessBenefit;
    NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
                                          initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
                                          options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
                                          documentAttributes:nil error:nil];
    [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
    [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
    self.cardDetail.attributedText = strAtt;
    [self.cardTitle setText:self.detailModel.memberName];
    [self.cardMoney setText:self.detailModel.memberAmount];
    [self.cardMoney setHidden:NO];
    [self.cardBack sd_setImageWithURL:[NSURL URLWithString:self.detailModel.titleUrl]
                              placeholderImage:[UIImage imageNamed:@"高级会员背景"]];
    [self.payMoneyBtn setTitle:[NSString stringWithFormat:@"确认支付  ￥%@",self.detailModel.memberAmount] forState:UIControlStateNormal];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)selectPayTypeButtonEvent:(UIButton *)sender
{
    if (!sender.selected)
    {
        sender.selected = YES;
        if ([sender isEqual:self.selectUB])
        {
            self.selectALPay.selected = NO;
        }
        else
        {
            self.selectUB.selected = NO;
        }
    }
}

- (IBAction)successPayMoneyButtonEvent:(id)sender
{
    [self loadViewController:@"BuyMemberSuccessViewController"];
    NSString *urlStr = BaseUrl;
    urlStr = [urlStr stringByAppendingString:@"api/memberlever/buy"];
    urlStr = [urlStr stringByAppendingFormat:@"?accesstoken=%@&levelId=%@&payType=alipay", DIF_CommonHttpAdapter.access_token, self.detailModel.levelId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]
                                       options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO}
                             completionHandler:^(BOOL success) {
                                 if (!success)
                                 {
                                     [CommonHUD delayShowHUDWithMessage:@"请先安装支付宝APP！" delayTime:2];
                                 }
                                 else
                                 {
                                     [CommonHUD hideHUD];
                                 }
                             }];
//    OpenAlipaysViewController *vc = [self loadViewController:@"OpenAlipaysViewController"];
//    vc.levelID = self.detailModel.levelId;
}
@end
