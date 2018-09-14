//
//  IncomeListBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "IncomeListBaseViewCell.h"

@interface IncomeListBaseView : BaseTableView

@property(nonatomic, strong) NSMutableArray<IncomeListModel *> *listModel;
@property (nonatomic, strong) NSString *noDataImageName;

@end
