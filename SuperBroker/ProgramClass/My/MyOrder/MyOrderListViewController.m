//
//  MyOrderListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "MyOrderListView.h"
#import "MyOrderDetailViewController.h"
#import "CarOrderDetailViewController.h"

@interface MyOrderListViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *insButtonView;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitConfirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIStackView *carInsButtonView;
@property (weak, nonatomic) IBOutlet UIButton *carAllBtn;
@property (weak, nonatomic) IBOutlet UIButton *carWaitPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *carHadMoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *carWaitReviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *carFinishBtn;

@end

@implementation MyOrderListViewController
{
    MyOrderListView *m_BaseView;
    NSInteger m_SegmentIndex;
    NSString *m_OrderStatus;
    NSString *m_CarOrderStatus;
    MyOrderInsuranceListModel *m_InsuModel;
    MyOrderCarListModel *m_CarModel;
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
    m_OrderStatus = @"";
    m_CarOrderStatus = @"";
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
        m_BaseView = [[MyOrderListView alloc] initWithFrame:self.contentView.frame];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            if (strongSelf->m_SegmentIndex == 0)
            {
                MyOrderDetailViewController *vc = [strongSelf loadViewController:@"MyOrderDetailViewController"];
                vc.detailModel = model;
            }
            else
            {
                CarOrderDetailViewController *vc = [strongSelf loadViewController:@"CarOrderDetailViewController"];
                vc.detailModel = model;
            }
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            if (strongSelf->m_SegmentIndex == 0)
            {
                [strongSelf httpRequestMyOrderInsuranceListWithParameters:@{@"orderStatus":strongSelf->m_OrderStatus,
                                                                            @"pageNum":@"1",@"pageSize":@"10"}];
            }
            else
            {
                [strongSelf httpRequestMyOrderCarListWithParameters:@{@"orderStatus":strongSelf->m_CarOrderStatus,
                                                                      @"pageNum":@"1",@"pageSize":@"10"}];
            }
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            if (strongSelf->m_SegmentIndex == 0)
            {
                [strongSelf httpRequestMyOrderInsuranceListWithParameters:@{@"orderStatus":strongSelf->m_OrderStatus,
                                                                            @"pageNum":[@(page+1) stringValue],@"pageSize":@"10"}];
            }
            else
            {
                [strongSelf httpRequestMyOrderCarListWithParameters:@{@"orderStatus":strongSelf->m_CarOrderStatus,
                                                                      @"pageNum":[@(page+1) stringValue],@"pageSize":@"10"}];
            }
        }];
    }
}

- (IBAction)chooseOrderTypeButtonEvent:(UISegmentedControl *)sender
{
    m_SegmentIndex = sender.selectedSegmentIndex;
    [m_BaseView showContentViewWithIndex:sender.selectedSegmentIndex];
    if (m_SegmentIndex == 0)
    {
        [self.insButtonView setHidden:NO];
        [self.carInsButtonView setHidden:YES];
    }
    else
    {
        [self.insButtonView setHidden:YES];
        [self.carInsButtonView setHidden:NO];
    }
}

- (IBAction)selectOrderStateButtonEvent:(UIButton *)sender
{
    [self.allBtn setSelected:NO];
    [self.waitPayBtn setSelected:NO];
    [self.waitConfirmBtn setSelected:NO];
    [self.finishBtn setSelected:NO];
    [sender setSelected:YES];
    if ([sender isEqual:self.allBtn])
    {
        m_OrderStatus = @"";
    }
    if ([sender isEqual:self.waitPayBtn])
    {
        m_OrderStatus = [@(ENUM_MyOrder_Status_WaitPay) stringValue];
    }
    if ([sender isEqual:self.waitConfirmBtn])
    {
        m_OrderStatus = [@(ENUM_MyOrder_Status_WaitConfirm) stringValue];
    }
    if ([sender isEqual:self.finishBtn])
    {
        m_OrderStatus = [@(ENUM_MyOrder_Status_Finish) stringValue];
    }
    [m_BaseView loadTableView];
}

- (IBAction)selectCarInsOrderStateButtonEvent:(UIButton *)sender
{
    [self.carAllBtn setSelected:NO];
    [self.carWaitPayBtn setSelected:NO];
    [self.carHadMoneyBtn setSelected:NO];
    [self.carWaitReviewBtn setSelected:NO];
    [self.carFinishBtn setSelected:NO];
    [sender setSelected:YES];
    if ([sender isEqual:self.carAllBtn])
    {
        m_CarOrderStatus = @"";
    }
    if ([sender isEqual:self.carWaitPayBtn])
    {
        m_CarOrderStatus = [@(ENUM_MyOrder_Car_Status_WaitPay) stringValue];
    }
    if ([sender isEqual:self.carHadMoneyBtn])
    {
        m_CarOrderStatus = [@(ENUM_MyOrder_Car_Status_HadMoney) stringValue];
    }
    if ([sender isEqual:self.carWaitReviewBtn])
    {
        m_CarOrderStatus = [@(ENUM_MyOrder_Car_Status_WaitReview) stringValue];
    }
    if ([sender isEqual:self.carFinishBtn])
    {
        m_CarOrderStatus = [@(ENUM_MyOrder_Car_Status_Finish) stringValue];
    }
    [m_BaseView loadTableView];
}
#pragma mark - Http Request

- (void)httpRequestMyOrderInsuranceListWithParameters:(NSDictionary *)parms
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyOrderInsuranceListWithParameters:parms
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endloadEvent];
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             strongSelf->m_InsuModel = [MyOrderInsuranceListModel mj_objectWithKeyValues:responseModel[@"data"]];
             if ([parms[@"pageNum"] integerValue] == 1)
             {
                 [strongSelf->m_BaseView setInsuranceList:strongSelf->m_InsuModel.list];
             }
             else if (strongSelf->m_InsuModel.list.count > 0)
             {
                 NSMutableArray *nowList = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.insuranceList];
                 [nowList addObjectsFromArray:strongSelf->m_InsuModel.list];
                 [strongSelf->m_BaseView setInsuranceList:nowList];
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
             [strongSelf->m_BaseView setInsuranceList:strongSelf->m_BaseView.insuranceList];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
    } FailedBlcok:^(NSError *error) {
        DIF_StrongSelf
        if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
        {
            [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
            [strongSelf->m_BaseView setInsuranceList:strongSelf->m_BaseView.insuranceList];
        }
        if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
        {
            [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
            [strongSelf->m_BaseView setInsuranceList:strongSelf->m_BaseView.insuranceList];
        }
        [strongSelf->m_BaseView endloadEvent];
        [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
    }];
}

- (void)httpRequestMyOrderCarListWithParameters:(NSDictionary *)parms
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyOrderCarListWithParameters:parms
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endloadEvent];
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             strongSelf->m_CarModel = [MyOrderCarListModel mj_objectWithKeyValues:responseModel[@"data"]];
             if ([parms[@"pageNum"] integerValue] == 1)
             {
                 [strongSelf->m_BaseView setCarList:strongSelf->m_CarModel.list];
             }
             else if (strongSelf->m_CarModel.list.count > 0)
             {
                 NSMutableArray *nowList = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.carList];
                 [nowList addObjectsFromArray:strongSelf->m_CarModel.list];
                 [strongSelf->m_BaseView setCarList:nowList];
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
             [strongSelf->m_BaseView setCarList:strongSelf->m_BaseView.carList];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             [strongSelf->m_BaseView setCarList:strongSelf->m_BaseView.carList];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             [strongSelf->m_BaseView setCarList:strongSelf->m_BaseView.carList];
         }
         [strongSelf->m_BaseView endloadEvent];
        [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
    }];
}

@end
