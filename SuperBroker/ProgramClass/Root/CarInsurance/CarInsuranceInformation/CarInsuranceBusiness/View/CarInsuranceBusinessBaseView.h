//
//  CarInsuranceBusinessBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "CarInsuranceBusinessViewCell.h"

@interface CarInsuranceBusinessBaseView : BaseTableView

@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, strong) NSArray *carspeciesList;
@property (nonatomic) BOOL isCanEdit;

@end
