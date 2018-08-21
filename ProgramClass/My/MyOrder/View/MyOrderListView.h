//
//  MyOrderListView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderListViewCell.h"

@interface MyOrderListView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, copy) tableViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy) tableViewLoadMoreBlock loadMoreBlock;

@property (nonatomic, strong) NSArray *insuranceList;
@property (nonatomic, strong) NSArray *carList;

@property (nonatomic, strong) NSString *noDataImageName;

- (void)loadTableView;
- (void)endloadEvent;
- (void)showContentViewWithIndex:(NSInteger)index;

@end
