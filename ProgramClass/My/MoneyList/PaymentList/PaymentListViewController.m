//
//  PaymentListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PaymentListViewController.h"
#import "PaymentListBaseView.h"

@interface PaymentListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *canUseNum;
@property (weak, nonatomic) IBOutlet UILabel *allHadNum;
@property (weak, nonatomic) IBOutlet UIView *contentBG;

@end

@implementation PaymentListViewController
{
    PaymentListBaseView *m_BaseView;
    PaymentListModel *m_ListModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"我的消费券"];
    [self setRightItemWithContentName:@"客服"];
    m_ListModel = [PaymentListModel new];
    m_BaseView = [[PaymentListBaseView alloc] initWithFrame:self.contentBG.bounds style:UITableViewStylePlain];
    m_BaseView.listModel = m_ListModel;
    [self.contentBG addSubview:m_BaseView];
}

@end
