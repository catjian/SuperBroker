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

- (void)showContentViewWithIndex:(NSInteger)index;

@end
