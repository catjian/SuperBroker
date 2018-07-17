//
//  PresentAccountViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentAccountViewController.h"

@interface PresentAccountViewController ()

@end

@implementation PresentAccountViewController
{
    PresentAccountModel *m_BaseViewModel;
    PresentAccountBaseView *m_BaseView;
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
    // Do any additional setup after loading the view.
    m_BaseViewModel = [PresentAccountModel new];
    [self setNavTarBarTitle:@"提现账户"];
    [self setRightItemWithContentName:@"完成"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[PresentAccountBaseView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        m_BaseView.objModel = m_BaseViewModel;
        [self.view addSubview:m_BaseView];
        
        DIF_WeakSelf(self);
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            if (indexPath.row == 1)
            {
                [strongSelf loadViewController:@"AddBankAccountViewController"];
            }
        }];
    }
}

@end
