//
//  IncomeListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IncomeListViewController.h"
#import "IncomeListBaseView.h"

@interface IncomeListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *canUserNum;
@property (weak, nonatomic) IBOutlet UILabel *allIncomeNum;
@property (weak, nonatomic) IBOutlet UIView *contentBG;

@end

@implementation IncomeListViewController
{
    IncomeListBaseView *m_BaseView;
    IncomeListModel *m_ListModel;
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
    [self setNavTarBarTitle:@"我的提现"];
    [self setRightItemWithContentName:@"客服-黑"];
    m_ListModel = [IncomeListModel new];
    m_BaseView = [[IncomeListBaseView alloc] initWithFrame:self.contentBG.bounds style:UITableViewStylePlain];
    [m_BaseView setWidth:DIF_SCREEN_WIDTH];
    m_BaseView.listModel = m_ListModel;
    [self.contentBG addSubview:m_BaseView];
}




@end
