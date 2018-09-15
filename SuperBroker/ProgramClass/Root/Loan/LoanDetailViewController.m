//
//  LoanDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanDetailViewController.h"
#import "ShowShareButtonView.h"
#import "LoanInformationViewController.h"

@interface LoanDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation LoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:self.listDetailModel.productName];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [CommonHUD delayShowHUDWithMessage:@"加载详情中..." delayTime:2];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.listDetailModel.detailsUrl]]];
}

#pragma mark - Button Events

- (IBAction)customServerButtonEvent:(id)sender {
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)shareButtonEvent:(id)sender {
    ShowShareButtonView *shareView = [[ShowShareButtonView alloc] initWithFrame:self.view.bounds];
//    shareView.shareContent = [NSString stringWithFormat:@"%@?prodId=%@&brokerId=%@&type=1", self.detailModel.shareUrl,self.detailModel.productId,self.detailModel.speciesId];
    shareView.shareContent = self.listDetailModel.shareUrl;
    shareView.title = self.listDetailModel.productName;
    shareView.descr = self.listDetailModel.summary;
    [self.view addSubview:shareView];
    [shareView show];
}

- (IBAction)applyButtonEvent:(id)sender {
    LoanInformationViewController *vc = [self loadViewController:@"LoanInformationViewController" hidesBottomBarWhenPushed:YES];
    vc.listDetailModel = self.listDetailModel;
}


@end
