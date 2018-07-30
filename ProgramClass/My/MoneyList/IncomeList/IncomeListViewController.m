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
    DIF_WeakSelf(self)
    [m_BaseView setRefreshBlock:^{
        DIF_StrongSelf
        [strongSelf httpRequestGetWithDrawalListWithPage:1];
    }];
    [m_BaseView setLoadMoreBlock:^(NSInteger page) {
        DIF_StrongSelf
        [strongSelf httpRequestGetWithDrawalListWithPage:page+1];
    }];
}

#pragma mark - Http Request

- (void)httpRequestGetWithDrawalListWithPage:(NSInteger)page
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestWithDrawalListWithParameters:@{@"pageNum":[@(page) stringValue]}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf->m_BaseView endRefresh];
             strongSelf->m_ListModel = [IncomeListModel mj_objectWithKeyValues:responseModel[@"data"]];
             strongSelf->m_BaseView.listModel = strongSelf->m_ListModel;
             [strongSelf->m_BaseView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
             [strongSelf.canUserNum setText:[NSString stringWithFormat:@"%.2f",strongSelf->m_ListModel.income.floatValue]];
             [strongSelf.allIncomeNum setText:[NSString stringWithFormat:@"%.2f",strongSelf->m_ListModel.incomeAll.floatValue]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}


@end
