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
        DIF_WeakSelf(self)
        [m_BaseView setBlock:^(NSArray *selectIndex) {
            DIF_StrongSelf
            if (!selectIndex)
            {
                if (strongSelf.block)
                {
                    strongSelf.block(nil);
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                return;
            }
            NSMutableArray *response = [NSMutableArray array];
            for (NSIndexPath *indexPath in selectIndex)
            {
                [response addObject:[@[@"58", @"59", @"60", @"61"] objectAtIndex:indexPath.row]];
            }
            if (strongSelf.block)
            {
                strongSelf.block(response);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    m_BaseView.ageStr = self.ageStr;
}

@end
