//
//  LoanCommitViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "LoanProductDetailModel.h"
#import "LoadCommitOrderModel.h"

@interface LoanCommitViewController : BaseViewController

@property (nonatomic, strong) LoanProductDetailModel *detailModel;
@property (nonatomic, strong) LoadCommitOrderModel *orderModel;

@end
