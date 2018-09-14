//
//  MyLoanOrderDetailFinishViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/5.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "MyLoadOrderDetailModel.h"
#import "MyOrderInsuranceDetailModel.h"

@interface MyLoanOrderDetailFinishViewController : BaseViewController

@property(nonatomic, strong) NSString *orderID;
@property(nonatomic, strong) MyLoadOrderDetailModel *orderDetail;

@end
