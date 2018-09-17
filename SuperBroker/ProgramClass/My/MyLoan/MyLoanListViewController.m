//
//  MyLoanListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyLoanListViewController.h"
#import "MyLoanBaseView.h"
#import "MyLoanOrderDetailViewController.h"
#import "MyLoanOrderDetailFinishViewController.h"

@interface MyLoanListViewController ()

@end

@implementation MyLoanListViewController
{
    MyLoanBaseView *m_BaseView;
    MyloadListModel *m_ListModel;
    NSMutableArray<UILabel *> *m_TopLabs;
    NSString *m_OrderStatus;
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
    [self setNavTarBarTitle:@"我的贷款"];
    [self setRightItemWithContentName:@"客服-黑"];
    m_ListModel = [MyloadListModel new];
    m_OrderStatus = @"";
    [self createTopView];
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
        m_BaseView = [[MyLoanBaseView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height-12) style:UITableViewStylePlain];
        m_BaseView.listModel = m_ListModel;
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
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            [strongSelf httpRequsetMyLoanOrderDetail:model];
        }];
    }
}


- (void)createTopView
{
    m_TopLabs = [NSMutableArray array];
    NSArray *titles = @[@"全部", @"待审核", @"待确认", @"已完成"];
    for (NSInteger i = 0; i < titles.count; i ++)
    {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(DIF_SCREEN_WIDTH / titles.count * i, 0, DIF_SCREEN_WIDTH / titles.count, DIF_PX(42));
        label.tag = i;
        label.font = DIF_DIFONTOFSIZE(14);
        [label setTextColor:DIF_HEXCOLOR(i==0?@"017aff":@"333333")];
        [label setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:titles[i]];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewLabelAction:)]];
        [self.view addSubview:label];
        [m_TopLabs addObject:label];
    }
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [line1 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [self.view addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(42), DIF_SCREEN_WIDTH, 1)];
    [line2 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [self.view addSubview:line2];
}

- (void)topViewLabelAction:(UITapGestureRecognizer *)tap
{
    for (UILabel *lab in m_TopLabs)
    {
        [lab setTextColor:DIF_HEXCOLOR(@"333333")];        
    }
    NSInteger index = tap.view.tag;
    UILabel *lab = m_TopLabs[index];
    [lab setTextColor:DIF_HEXCOLOR(@"017aff")];
    NSArray *status = @[@"",@"13",@"83",@"15"];
    m_OrderStatus = status[index];
    [m_BaseView.mj_header beginRefreshing];
}

#pragma mark - Http Request

- (void)httpRequestGetInviteListWithPageNumber:(NSInteger)pageNum
{    
    DIF_WeakSelf(self);
    [DIF_CommonHttpAdapter
     httpRequestMyloanListWithParameters:@{@"orderStatus":m_OrderStatus?m_OrderStatus:@"", @"pageNum":[@(pageNum) stringValue],@"pageSize":@"10"}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             strongSelf->m_ListModel = [MyloadListModel mj_objectWithKeyValues:responseModel[@"data"]];
             if (pageNum == 1)
             {
                 [strongSelf->m_BaseView setListArrModel:strongSelf->m_ListModel.list];
             }
             else if (strongSelf->m_ListModel.list.count > 0)
             {
                 NSMutableArray *nowList = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.listArrModel];
                 [nowList addObjectsFromArray:strongSelf->m_ListModel.list];
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
             [strongSelf->m_BaseView setListModel:nil];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             [strongSelf->m_BaseView setListModel:nil];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             [strongSelf->m_BaseView setListModel:nil];
         }
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequsetMyLoanOrderDetail:(MyloadListDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self);
    [DIF_CommonHttpAdapter
     httpRequestMyloanOrderDetailWithParameters:@{@"orderId":model.orderId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             
             MyLoadOrderDetailModel *detailModel = [MyLoadOrderDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             MyLoadInsuranceOrderModel *insuranceOrder = [MyLoadInsuranceOrderModel mj_objectWithKeyValues:detailModel.insuranceOrder];
             if (insuranceOrder.orderStatus.integerValue==15)
             {
                 MyLoanOrderDetailFinishViewController *vc = [self loadViewController:@"MyLoanOrderDetailFinishViewController"];
                 vc.orderDetail = [MyLoadOrderDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
                 vc.orderID = model.orderId;
             }
             else
             {
                 MyLoanOrderDetailViewController *vc = [self loadViewController:@"MyLoanOrderDetailViewController"];
                 vc.orderDetail = [MyLoadOrderDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
                 vc.orderID = model.orderId;
             }
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
