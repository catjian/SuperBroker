//
//  LoanDetailViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "LoanProductDetailModel.h"
#import "RootLoanDetailModel.h"

@interface LoanDetailViewController : BaseViewController

@property (nonatomic, strong) RootLoanDetailModel *listDetailModel;
@property (nonatomic, strong) LoanProductDetailModel *detailModel;

@end
