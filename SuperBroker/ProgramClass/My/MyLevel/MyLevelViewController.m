//
//  MyLevelViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/5.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyLevelViewController.h"
#import "MyLevelDataModel.h"

@interface MyLevelViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topBackImage;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLab;
@property (weak, nonatomic) IBOutlet UILabel *memberTimeLab;


@property (weak, nonatomic) IBOutlet UILabel *warnLable;
@property (weak, nonatomic) IBOutlet UILabel *LevelAllTitle;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;

@property (weak, nonatomic) IBOutlet UIView *businessView;
@property (weak, nonatomic) IBOutlet UIImageView *businessIcon;
@property (weak, nonatomic) IBOutlet UILabel *businessTitle;
@property (weak, nonatomic) IBOutlet UIWebView *businessContentView;
@property (weak, nonatomic) IBOutlet UIView *businessLine;

@property (weak, nonatomic) IBOutlet UIView *brokerView;
@property (weak, nonatomic) IBOutlet UIImageView *brokerIcon;
@property (weak, nonatomic) IBOutlet UILabel *brokerTitle;
@property (weak, nonatomic) IBOutlet UIWebView *brokerContentView;
@property (weak, nonatomic) IBOutlet UIView *brokerLine;

@property (weak, nonatomic) IBOutlet UIView *juniorView;
@property (weak, nonatomic) IBOutlet UIImageView *juniorIcon;
@property (weak, nonatomic) IBOutlet UILabel *juniorTitle;
@property (weak, nonatomic) IBOutlet UIWebView *juniorContent;
@property (weak, nonatomic) IBOutlet UIView *juniorLine;

@end

@implementation MyLevelViewController
{
    MyLevelDataModel *m_levelModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self setNavBarBackGroundColor:@"000000"];
    [self setStatusBarBackgroundColor:DIF_HEXCOLOR(@"000000")];
    [self.navigationController setNavigationBarHidden:NO];
    [self preferredStatusBarStyle];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarBackGroundColor:@"000000"];
    [self setStatusBarBackgroundColor:DIF_HEXCOLOR(@"000000")];
    [[self setNavTarBarTitle:@"我的权益"] setTextColor:DIF_HEXCOLOR(@"ffffff")];
    [self setRightItemWithContentName:@"客服-白色"];
    UIButton * leftBtn = [self setLeftItemWithContentName:@"返回箭头-白"];
    [leftBtn setLeft:0];
    UIImage *btnImage = [UIImage imageNamed:@"返回箭头-白"];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -(leftBtn.frame.size.width - btnImage.size.width), 0, 0)];
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"全部权益"];
    [attStr attatchImage:[UIImage imageNamed:@"全部权益"]
              imageFrame:CGRectMake(6, 0, 10, 9)
                   Range:NSMakeRange(attStr.length, 0)];
    [attStr attatchImage:[UIImage imageNamed:@"全部权益"]
              imageFrame:CGRectMake(-6, 0, 10, 9)
                   Range:NSMakeRange(0, 0)];
    [self.LevelAllTitle setAttributedText:attStr];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self httpRequestMemberLeverMyLevel];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

#pragma mark - Http Request

- (void)httpRequestMemberLeverMyLevel
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMemberLeverMyLevelResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf loadMyLevelDataToViewWithData:responseModel[@"data"]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)loadMyLevelDataToViewWithData:(NSDictionary *)data
{
    m_levelModel = [MyLevelDataModel mj_objectWithKeyValues:data];
    NSDictionary *levelNames = @{@"6":@"钻石级经纪人背景", @"7":@"白金级经纪人背景", @"8":@"黄金级经纪人背景", @"82":@"白银级经纪人背景"};
//    [self.topBackImage sd_setImageWithURL:[NSURL URLWithString:m_levelModel.titleUrl]
//                         placeholderImage:[UIImage imageNamed:[m_levelModel.memberName stringByAppendingString:@"背景"]]];
    [self.topBackImage sd_setImageWithURL:[NSURL URLWithString:m_levelModel.titleUrl]
                         placeholderImage:[UIImage imageNamed:levelNames[m_levelModel.payType]]];
    [self.memberNameLab setText:m_levelModel.memberName];
    [self.memberTimeLab setText:
     [NSString stringWithFormat:@"权益生效时间：%@",[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:m_levelModel.memberTime.integerValue/1000]
                                                              Formate:@"yyyy.MM.dd"]]];
    CGFloat top_Offset = self.businessView.top;
    if (m_levelModel.businessBenefit.length > 0)
    {
        CGRect attrsRect = [m_levelModel.businessBenefit boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                   attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(20)}
                                                                      context:nil];
        int num = ceil(attrsRect.size.width/self.businessContentView.width);
        self.businessView.height = 61 + 30*(num);
        top_Offset = self.businessView.bottom;
    }
    else
    {
        [self.businessView setHidden:YES];
    }

    if (m_levelModel.brokerBenefit.length > 0)
    {
        CGRect attrsRect = [m_levelModel.brokerBenefit boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(20)}
                                                             context:nil];
        int num = ceil(attrsRect.size.width/self.brokerContentView.width);
        [self.brokerView setTop:top_Offset];
        self.brokerView.height = 61 + 32*(num);
        top_Offset = self.brokerView.bottom;
    }
    else
    {
        [self.brokerView setHidden:YES];
    }

    if (m_levelModel.juniorBenefit.length > 0)
    {
        CGRect attrsRect = [m_levelModel.juniorBenefit boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                 attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(20)}
                                                                    context:nil];
        int num = ceil(attrsRect.size.width/self.juniorContent.width);
        [self.juniorView setTop:self.brokerView.bottom];
        self.juniorView.height = 61 + 30*(num);
    }
    else
    {
        [self.juniorView setHidden:YES];
    }
    [self.contentScroll setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.juniorView.bottom)];
    DIF_WeakSelf(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DIF_StrongSelf
        CGRect attrsRect = [strongSelf->m_levelModel.businessBenefit boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                   attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(20)}
                                                                      context:nil];
        int num = ceil(attrsRect.size.width/strongSelf.businessContentView.width);
        [strongSelf.businessContentView setHeight:30*num];
        [strongSelf.businessContentView setDelegate:self];
        [strongSelf.businessContentView loadHTMLString:strongSelf->m_levelModel.businessBenefit baseURL:nil];
        [strongSelf.businessLine setTop:strongSelf.businessView.height-1];
        
        attrsRect = [strongSelf->m_levelModel.brokerBenefit boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(20)}
                                                             context:nil];
        num = ceil(attrsRect.size.width/self.brokerContentView.width);
        [strongSelf.brokerContentView setHeight:33*num];
        [strongSelf.brokerContentView setDelegate:self];
        [strongSelf.brokerContentView loadHTMLString:strongSelf->m_levelModel.brokerBenefit baseURL:nil];
        [strongSelf.brokerLine setTop:strongSelf.brokerView.height-1];

        attrsRect = [strongSelf->m_levelModel.juniorBenefit boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(20)}
                                                             context:nil];
        num = ceil(attrsRect.size.width/strongSelf.juniorContent.width);
        [strongSelf.juniorContent setHeight:30*num];
        [strongSelf.juniorContent setDelegate:self];
        [strongSelf.juniorContent loadHTMLString:strongSelf->m_levelModel.juniorBenefit baseURL:nil];
        [strongSelf.juniorLine setTop:strongSelf.juniorView.height-1];
    });
    
}

- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    //重写contentSize,防止左右滑动
    CGSize size = webView.scrollView.contentSize;
    size.width= webView.scrollView.frame.size.width;
    size.height= webView.scrollView.frame.size.height;
    webView.scrollView.contentSize= size;
}

@end
