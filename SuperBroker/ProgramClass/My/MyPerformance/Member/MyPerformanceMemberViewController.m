//
//  MyPerformanceMemberViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/6.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyPerformanceMemberViewController.h"
#import "MyPerformanceMemberBaseView.h"

@interface MyPerformanceMemberViewController ()

@end

@implementation MyPerformanceMemberViewController
{
    MyPerformanceMemberBaseView *m_BaseView;
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
    [self setNavTarBarTitle:@"我的推广业绩"];
    [self setRightItemWithContentName:@"客服-黑"];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 12)];
    [topView setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self.view addSubview:topView];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [topView addSubview:lineT];
    
    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, 11, DIF_SCREEN_WIDTH, 1)];
    [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [topView addSubview:lineB];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[MyPerformanceMemberBaseView alloc] initWithFrame:CGRectMake(0, 12, self.view.width, self.view.height-12) style:UITableViewStylePlain];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self);
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            [strongSelf httpRequestGetInviteListWithPageNumber:1];
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            [strongSelf httpRequestGetInviteListWithPageNumber:page+1];
        }];
    }
}

#pragma mark - Http Request

- (void)httpRequestGetInviteListWithPageNumber:(NSInteger)pageNum
{
    DIF_WeakSelf(self);
    [DIF_CommonHttpAdapter
     httpRequestMyPerformanceMemberWithParameters:@{@"pageNum":[@(pageNum) stringValue],@"pageSize":@"10"}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             MyPerformanceMemberListModel *listModle = [MyPerformanceMemberListModel mj_objectWithKeyValues:responseModel[@"data"]];
             if (pageNum == 1)
             {
                 [strongSelf->m_BaseView setListArrModel:listModle.list];
             }
             else if (listModle.list.count > 0)
             {
                 NSMutableArray *nowList = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.listArrModel];
                 [nowList addObjectsFromArray:listModle.list];
                 [strongSelf->m_BaseView setListArrModel:nowList];
             }
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
             [strongSelf->m_BaseView setListArrModel:strongSelf->m_BaseView.listArrModel];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             [strongSelf->m_BaseView setListArrModel:strongSelf->m_BaseView.listArrModel];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             [strongSelf->m_BaseView setListArrModel:strongSelf->m_BaseView.listArrModel];
         }
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
