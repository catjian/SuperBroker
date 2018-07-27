//
//  CarOrderDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderDetailViewController.h"

@interface CarOrderDetailViewController ()

@end

@implementation CarOrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"订单详情"];
    [self setRightItemWithContentName:@"客服-黑"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT-64)];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self.view addSubview:scrollView];
    
    CarOrderStateView *stateView = [[CarOrderStateView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [stateView.stateLab setText:@"待付款"];
    [stateView.companyName setText:@"天安保险"];
    [scrollView addSubview:stateView];
    
    CarOrderThreeLineContentView *ownerView = [[CarOrderThreeLineContentView alloc] initWithFrame:CGRectMake(0, stateView.bottom, 0, 0)];
    [ownerView.titleLab setText:@"车主信息"];
    [ownerView.contentFriLab setText:@"姓名：王五"];
    [ownerView.contentSecLab setText:@"姓名：王五"];
    [ownerView.contentThrLab setText:@"姓名：王五"];
    [scrollView addSubview:ownerView];
    
    CarInformationView *carInfoView = [[CarInformationView alloc] initWithFrame:CGRectMake(0, ownerView.bottom, 0, 0)];
    [carInfoView.titleLab setText:@"车辆信息"];
    [carInfoView.contentFriLab setText:@"姓名：王五"];
    [carInfoView.contentSecLab setText:@"姓名：王五"];
    [carInfoView.contentThrLab setText:@"姓名：王五"];
    [carInfoView.contentFourLab setText:@"姓名：王五"];
    [carInfoView.userCardImage setBackgroundColor:[UIColor redColor]];
    [carInfoView.driverCardImage setBackgroundColor:[UIColor yellowColor]];
    [scrollView addSubview:carInfoView];
    
    CarOrderThreeLineContentView *customerView = [[CarOrderThreeLineContentView alloc] initWithFrame:CGRectMake(0, carInfoView.bottom, 0, 0)];
    [customerView.titleLab setText:@"投保人信息"];
    [customerView.contentFriLab setText:@"姓名：王五"];
    [customerView.contentSecLab setText:@"姓名：王五"];
    [customerView.contentThrLab setText:@"姓名：王五"];
    [scrollView addSubview:customerView];
    
    CarOrderDateView *dateView = [[CarOrderDateView alloc] initWithFrame:CGRectMake(0, customerView.bottom, 0, 0)];
    dateView.height -= DIF_PX(24);
    [dateView.contentFriLab setText:@"订单编号：131312"];
    [dateView.contentSecLab setText:@"订单编号：131312"];
    [dateView.contentThrLab setText:@"订单编号：131312"];
    [dateView.contentThrLab setAlpha:0];
    [scrollView addSubview:dateView];
    
    CarOrderCancelButtonView *cancelView = [[CarOrderCancelButtonView alloc] initWithFrame:CGRectMake(0, dateView.bottom, 0, 0)];
    [scrollView addSubview:cancelView];
    [scrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, cancelView.bottom+55)];
}

@end
