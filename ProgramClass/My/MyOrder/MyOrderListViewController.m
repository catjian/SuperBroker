//
//  MyOrderListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "MyOrderListView.h"

@interface MyOrderListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitConfirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation MyOrderListViewController
{
    MyOrderListView *m_BaseView;
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
    [self setNavTarBarTitle:@"我的订单"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    
    if (!m_BaseView)
    {
        m_BaseView = [[MyOrderListView alloc] initWithFrame:self.contentView.frame];
        [self.view addSubview:m_BaseView];
    }
}

- (IBAction)chooseOrderTypeButtonEvent:(UISegmentedControl *)sender
{
    [m_BaseView showContentViewWithIndex:sender.selectedSegmentIndex];
}

- (IBAction)selectOrderStateButtonEvent:(UIButton *)sender
{
    [self.allBtn setSelected:NO];
    [self.waitPayBtn setSelected:NO];
    [self.waitConfirmBtn setSelected:NO];
    [self.finishBtn setSelected:NO];
    [sender setSelected:YES];
}
@end
