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
    NSMutableArray<IncomeListModel *> * m_ListModel;
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
    m_ListModel = [NSMutableArray array];
    NSString *income =  [DIF_APPDELEGATE.mybrokeramount[@"income"] stringValue];
    income = income?income:@"0";
    [self.canUserNum setText:[NSString stringWithFormat:@"%@",income]];
    NSString *incomeAll =  [DIF_APPDELEGATE.mybrokeramount[@"incomeAll"] stringValue];
    incomeAll = incomeAll?incomeAll:@"0";
    [self.allIncomeNum setText:[NSString stringWithFormat:@"%@", incomeAll]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {        
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
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

#pragma mark - Http Request

- (void)httpRequestGetWithDrawalListWithPage:(NSInteger)page
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestWithDrawalListWithParameters:@{@"pageNum":[@(page) stringValue],@"pageSize":@"10"}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             if (page == 1)
             {
                 [strongSelf->m_ListModel removeAllObjects];
                 [strongSelf->m_ListModel addObject:[IncomeListModel mj_objectWithKeyValues:responseModel[@"data"]]];
                 strongSelf->m_BaseView.listModel = strongSelf->m_ListModel;
             }
             else
             {
                 IncomeListModel *listModel = [IncomeListModel mj_objectWithKeyValues:responseModel[@"data"]];
                 [strongSelf->m_ListModel addObject:listModel];
                 strongSelf->m_BaseView.listModel = strongSelf->m_ListModel;
             }
             [strongSelf->m_BaseView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
         }
         else
         {
             if ([responseModel[@"message"] rangeOfString:@"网络连接失败"].location != NSNotFound )
             {
                 [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             }
             else
             {
                 [strongSelf->m_BaseView setNoDataImageName:@"数据错误"];
             }
             [strongSelf->m_BaseView reloadData];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             [strongSelf->m_BaseView reloadData];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             [strongSelf->m_BaseView reloadData];
         }
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}


@end
