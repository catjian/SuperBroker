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
    NSInteger m_SegmentIndex;
    NSString *m_OrderStatus;
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
                [strongSelf loadViewController:@"MyOrderDetailViewController"];
            }
            else
            {
                [strongSelf loadViewController:@"CarOrderDetailViewController"];
            }
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            if (strongSelf->m_SegmentIndex == 0)
            {
                [strongSelf httpRequestMyOrderInsuranceListWithParameters:@{@"orderStatus":strongSelf->m_OrderStatus}];
            }
            else
            {
                [strongSelf httpRequestMyOrderCarListWithParameters:@{@"orderStatus":strongSelf->m_OrderStatus}];
            }
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            if (strongSelf->m_SegmentIndex == 0)
            {
                [strongSelf httpRequestMyOrderInsuranceListWithParameters:@{@"orderStatus":strongSelf->m_OrderStatus}];
            }
            else
            {
                [strongSelf httpRequestMyOrderCarListWithParameters:@{@"orderStatus":strongSelf->m_OrderStatus}];
            }
        }];
    }
}

- (IBAction)chooseOrderTypeButtonEvent:(UISegmentedControl *)sender
{
    m_SegmentIndex = sender.selectedSegmentIndex;
    [m_BaseView showContentViewWithIndex:sender.selectedSegmentIndex];
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
             strongSelf->m_InsuModel = [MyOrderInsuranceListModel mj_objectWithKeyValues:responseModel];
             [strongSelf->m_BaseView setInsuranceList:strongSelf->m_InsuModel.list];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
    } FailedBlcok:^(NSError *error) {
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
             strongSelf->m_CarModel = [MyOrderCarListModel mj_objectWithKeyValues:responseModel];
             [strongSelf->m_BaseView setCarList:strongSelf->m_CarModel.list];
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
