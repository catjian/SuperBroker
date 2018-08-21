//
//  CarInsuranceBusinessViewCell.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CarInsuranceProvince.h"

@interface CarInsuranceBusinessViewCell : BaseTableViewCell

@property (nonatomic) BOOL isDeductible;
@property (nonatomic, strong) NSString *insuredAmount;
@property (nonatomic) BOOL isCanEdit;

@end
