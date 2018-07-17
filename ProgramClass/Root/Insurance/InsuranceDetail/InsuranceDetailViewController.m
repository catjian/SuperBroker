//
//  InsuranceDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceDetailViewController.h"
#import "ShowShareButtonView.h"

@interface InsuranceDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end

@implementation InsuranceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"产品名称xxxxxx"];
}

#pragma mark - button events

- (IBAction)serviceButtonEvent:(id)sender
{
}

- (IBAction)shareButtonEvent:(id)sender
{
    ShowShareButtonView *shareView = [[ShowShareButtonView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:shareView];
    [shareView show];
}

- (IBAction)buyButtonEvent:(id)sender
{
    [self loadViewController:@"InsuranceInformationViewController" hidesBottomBarWhenPushed:YES];
}

@end
