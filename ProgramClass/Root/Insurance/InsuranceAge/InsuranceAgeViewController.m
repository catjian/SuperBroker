//
//  InsuranceAgeViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceAgeViewController.h"
#import "InsuranceAgeBaseView.h"

@interface InsuranceAgeViewController ()

@end

@implementation InsuranceAgeViewController
{
    InsuranceAgeBaseView *m_BaseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"选择年龄"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[InsuranceAgeBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
    }
}

@end
