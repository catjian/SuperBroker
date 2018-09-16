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
    NSMutableArray<PaymentListModel *> * m_ListModel;
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
    [self setRightItemWithContentName:@"客服-黑"];
    m_ListModel = [NSMutableArray array];
    m_BaseView = [[PaymentListBaseView alloc] initWithFrame:self.contentBG.bounds style:UITableViewStylePlain];
    [m_BaseView setWidth:DIF_SCREEN_WIDTH];
    [self.contentBG addSubview:m_BaseView];
    NSString *vouchers =  [DIF_APPDELEGATE.mybrokeramount[@"vouchers"] stringValue];
    vouchers = vouchers?vouchers:@"0";
    [self.canUseNum setText:[NSString stringWithFormat:@"%@", vouchers]];
    NSString *vouchersAll =  [DIF_APPDELEGATE.mybrokeramount[@"vouchersAll"] stringValue];
    vouchersAll = vouchersAll?vouchersAll:@"0";
    [self.allHadNum setText:[NSString stringWithFormat:@"%@", vouchersAll]];
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
     httpRequestMyrokercCouponListWithParameters:@{@"pageNum":[@(page) stringValue],@"pageSize":@"10"}
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
                 [strongSelf->m_ListModel addObject:[PaymentListModel mj_objectWithKeyValues:responseModel[@"data"]]];
                 strongSelf->m_BaseView.listModel = strongSelf->m_ListModel;
             }
             else
             {
                 PaymentListModel *listModel = [PaymentListModel mj_objectWithKeyValues:responseModel[@"data"]];
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
