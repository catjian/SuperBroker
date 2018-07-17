//
//  InsuranceTypesViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceTypesViewController.h"
#import "InsuranceTypesBaseView.h"

@interface InsuranceTypesViewController ()

@end

@implementation InsuranceTypesViewController
{
    InsuranceTypesBaseView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavTarBarTitle:@"保险种类"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[InsuranceTypesBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
    }
}

@end
