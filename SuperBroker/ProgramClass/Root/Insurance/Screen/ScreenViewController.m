//
//  ScreenViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ScreenViewController.h"
#import "ScreenBaseView.h"


@interface ScreenViewController ()

@end

@implementation ScreenViewController
{
    ScreenBaseView *m_BaseView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTarBarTitle:@"更多筛选"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[ScreenBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        [self httpRequestInsuranceFiltrate];
        DIF_WeakSelf(self)
        [m_BaseView setBlock:^(NSArray *selectIndex) {
            DIF_StrongSelf
            if (!selectIndex)
            {
                if (strongSelf.block)
                {
                    strongSelf.block(nil,nil);
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                return;
            }
            NSMutableArray *OrderType = [NSMutableArray array];
            NSMutableArray *consumptionType = [NSMutableArray array];
            for (NSIndexPath *indexPath in selectIndex)
            {
                NSDictionary *dic = strongSelf->m_BaseView.screenArr[indexPath.section];
                ScreenDataModel *model = [ScreenDataModel mj_objectWithKeyValues:dic];
                ScreenDetailDataModel *detailModel = [ScreenDetailDataModel mj_objectWithKeyValues:model.list[indexPath.row]];
                if (indexPath.section == 0)
                {
                    [OrderType addObject:detailModel.dictId];
                }
                else
                {
                    [consumptionType addObject:detailModel.dictId];
                }
            }
            if (strongSelf.block)
            {
                strongSelf.block(OrderType,consumptionType);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    m_BaseView.orderTypeStr = self.orderTypeStr;
    m_BaseView.consumptionTypeStr = self.consumptionTypeStr;
}

#pragma mark - Http Request

- (void)httpRequestInsuranceFiltrate
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceFiltrateResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_BaseView.screenArr = responseModel[@"data"];
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
