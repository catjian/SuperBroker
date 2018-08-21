//
//  MyIncomeListBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "MyIncomeListBaseViewCell.h"

@interface MyIncomeListBaseView : BaseTableView

@property(nonatomic, strong) NSMutableArray<MyIncomeListModel *> *listModel;
@property (nonatomic, strong) NSString *noDataImageName;

@end
