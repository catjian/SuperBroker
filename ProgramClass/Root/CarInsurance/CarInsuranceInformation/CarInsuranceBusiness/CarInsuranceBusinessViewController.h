//
//  CarInsuranceBusinessViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "CarInsuranceListModel.h"
#import "CarInsuranceProvince.h"

@interface CarInsuranceBusinessViewController : BaseViewController

@property (nonatomic, strong) CarInsuranceListModel *detailModel;
@property (nonatomic, strong) CarInsuranceCustomerDetail *buyCustomDetail;
@property (nonatomic) BOOL isCanEdit;
@property (nonatomic, strong) NSArray *carspeciesList;

@property (nonatomic, copy) NSString *generalizeAmountNum;

@end
