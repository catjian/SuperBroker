//
//  InsuranceDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceDetailViewController.h"
#import "ShowShareButtonView.h"
#import "InsuranceInformationViewController.h"

@interface InsuranceDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *prodNameLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *periodLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *premiumLab;
@property (weak, nonatomic) IBOutlet UILabel *promotionRewardsLab;
@property (weak, nonatomic) IBOutlet UIStackView *detailOneStackView;
@property (weak, nonatomic) IBOutlet UIStackView *coverageStackView;
@property (weak, nonatomic) IBOutlet UIView *tabButtonView;
@property (weak, nonatomic) IBOutlet UIView *contentImagesView;
@property (weak, nonatomic) IBOutlet UIView *instructionsBackView;
@property (weak, nonatomic) IBOutlet UILabel *instructionsTitle;
@property (weak, nonatomic) IBOutlet UIWebView *instructionsContentWebView;
@property (weak, nonatomic) IBOutlet UIButton *instructionsMoreBtn;
@property (weak, nonatomic) IBOutlet UIStackView *ProductTermsStackView;
@property (weak, nonatomic) IBOutlet UIView *claimsServiceBackView;
@property (weak, nonatomic) IBOutlet UILabel *claimsServiceTitle;
@property (weak, nonatomic) IBOutlet UIWebView *claimsServiceContentWebView;
@property (weak, nonatomic) IBOutlet UIView *contentWebBackView;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@property (weak, nonatomic) IBOutlet UIWebView *htmlWebView;
@end

@implementation InsuranceDetailViewController
{
    BOOL m_IsPush;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.detailModel = nil;
    [self setNavTarBarTitle:self.productModel.prodName];
    m_IsPush = NO;
//    [self httpRequestInsuranceProductDetailWithListModel:self.productModel];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.htmlWebView loadRequest:
//     [NSURLRequest requestWithURL:
//      [NSURL URLWithString:
//       [NSString stringWithFormat:@"%@?prodId=%@&brokerId=%@", self.detailModel.shareDomain,self.detailModel.prodId,self.detailModel.brokerId]]]];
    [CommonHUD delayShowHUDWithMessage:@"加载详情中..." delayTime:2];
    [self.htmlWebView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:self.productModel.detailsUrl]]];
//    [self.prodNameLab setText:self.detailModel.prodName];
//    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.titlePictureUrl]];
//    [self.ageLab setText:[NSString stringWithFormat:@"投保年龄：%@周岁",self.detailModel.age]];
//    [self.periodLab setText:[NSString stringWithFormat:@"保障期：%@年",self.detailModel.period]];
//    [self.orderTypeLab setText:[NSString stringWithFormat:@"保险类型：%@",self.detailModel.orderType]];
//    
//    NSString *premiumStr = [NSString stringWithFormat:@"%.2f元起",self.detailModel.premium.floatValue];
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:premiumStr];
//    [attStr FontAttributeNameWithFont:DIF_UIFONTOFSIZE(22) Range:NSMakeRange(0, [premiumStr rangeOfString:@"元起"].location+1)];
//    [attStr FontAttributeNameWithFont:DIF_UIFONTOFSIZE(13) Range:[premiumStr rangeOfString:@"元起"]];
//    [self.premiumLab setAttributedText:attStr];
//    [self.promotionRewardsLab setText:[NSString stringWithFormat:@"推广奖励：%@元",self.detailModel.promotionRewards]];
//    
//    UILabel *summary = [[self.detailOneStackView viewWithTag:1] viewWithTag:11];
//    [summary setText:self.detailModel.summary];
//    for (int i = 2; i<=4; i++)
//    {
//        [[self.detailOneStackView viewWithTag:i] setAlpha:0];
//    }
//    for (int i = 2; i<=4; i++)
//    {
//        [[self.coverageStackView viewWithTag:i] setAlpha:0];
//    }
//    
//    CommonPageControlView *pageView = [[CommonPageControlView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(42))
//                                                                            titles:@[@"产品特色",@"投保须知",@"产品条款",@"理赔服务"]
//                                                                          oneWidth:DIF_SCREEN_WIDTH/4-18];
//    [self.tabButtonView addSubview:pageView];
//    DIF_WeakSelf(self)
//    [pageView setSelectBlock:^(NSInteger page) {
//        DIF_StrongSelf
//    }];
//    //    [self.instructionsContentWebView loadHTMLString:self.detailModel.instructions baseURL:nil];
//    //    [self.claimsServiceContentWebView loadHTMLString:self.detailModel.claimsService baseURL:nil];
//    //    CGRect attrsRect = [self.detailModel.claimsService boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
//    //                                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//    //                                                                attributes:@{NSFontAttributeName : DIF_UIFONTOFSIZE(14)}
//    //                                                                   context:nil];
//    //    NSInteger row = ceil(attrsRect.size.width/self.claimsServiceContentWebView.width);
//    //    CGFloat height = row * attrsRect.size.height;
//    //    [self.claimsServiceContentWebView setHeight:height];
//    //    [self.claimsServiceBackView setHeight:self.claimsServiceContentWebView.bottom+45];
//    NSString *htmlStr = self.detailModel.details;
//    NSMutableString *mutStr = [NSMutableString stringWithString:htmlStr];
//    NSRange range = NSMakeRange(0, 0);
//    range = [htmlStr rangeOfString:@"<img"];
//    if (range.location == NSNotFound)
//    {
//        [mutStr appendString:htmlStr];
//    }
//    else
//    {
//        while (1)
//        {
//            range = [[mutStr substringFromIndex:range.location] rangeOfString:@"<img"];
//            if (range.location == NSNotFound)
//            {
//                break;
//            }
//            NSRange rangewidth = [[mutStr substringFromIndex:range.location] rangeOfString:@"width="];
//            NSRange rangeheight = [[mutStr substringFromIndex:range.location] rangeOfString:@"height="];
//            NSRange rangeEnd = [[mutStr substringFromIndex:range.location+rangeheight.location+rangeheight.length+1] rangeOfString:@"\""];
//            [mutStr replaceCharactersInRange:
//             NSMakeRange(rangewidth.location+range.location,
//                         rangeEnd.location+rangeheight.location+rangeheight.length+1-rangewidth.location+1)
//                                  withString:@"style=\"width:100%; height:auto\""];
//            range = NSMakeRange(rangeheight.location+rangeheight.length+range.location, 1);
//        }
//    }
//    [self.contentWebView loadHTMLString:mutStr baseURL:nil];
//    [self.contentView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.contentWebBackView.bottom+12)];
//    [self.contentView setScrollEnabled:YES];
}

#pragma mark - button events

- (IBAction)instructionsMoreButtonEvent:(id)sender
{
}

- (IBAction)serviceButtonEvent:(id)sender
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)shareButtonEvent:(id)sender
{
    ShowShareButtonView *shareView = [[ShowShareButtonView alloc] initWithFrame:self.view.bounds];
//    shareView.shareContent = [NSString stringWithFormat:@"%@?prodId=%@&brokerId=%@&type=1", self.detailModel.shareDomain,self.detailModel.prodId,self.detailModel.brokerId];
    shareView.shareContent = self.productModel.shareUrl;
    shareView.title = self.productModel.prodName;
    shareView.descr = self.detailModel.summary;
    [self.view addSubview:shareView];
    [shareView show];
}

- (IBAction)buyButtonEvent:(id)sender
{
    if (DIF_APPDELEGATE.brokerInfoModel.brokerType.integerValue == 64)
    {
        [self.view makeToast:@"普通经纪人无权购买车险/保险" duration:2 position:CSToastPositionCenter];
        return;
    }
    m_IsPush = YES;
    if (self.detailModel)
    {
        InsuranceInformationViewController *vc = [self loadViewController:@"InsuranceInformationViewController" hidesBottomBarWhenPushed:YES];
        vc.detailModel = self.detailModel;
    }
    else
    {
        [self httpRequestInsuranceProductDetailWithListModel:self.productModel];
    }
}

- (void)httpRequestInsuranceProductDetailWithListModel:(InsuranceProductDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceProductDetailWithParameters:@{@"prodId":model.prodId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             if (strongSelf->m_IsPush)
             {
                 InsuranceInformationViewController *vc = [strongSelf loadViewController:@"InsuranceInformationViewController" hidesBottomBarWhenPushed:YES];
                 strongSelf.detailModel = [InsuranceProductDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
                 vc.detailModel = strongSelf.detailModel;
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
