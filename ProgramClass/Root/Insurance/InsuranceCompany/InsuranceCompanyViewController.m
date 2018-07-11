//
//  InsuranceCompanyViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceCompanyViewController.h"
#import "InsuranceCompanyBaseView.h"

@interface InsuranceCompanyViewController ()

@end

@implementation InsuranceCompanyViewController
{
    InsuranceCompanyBaseView *m_BaseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"保险公司"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    m_BaseView = [[InsuranceCompanyBaseView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:m_BaseView];
}

@end
