//
//  SpecialNewsBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialNewsViewImageCell.h"
#import "SpecialNewsViewMoreImageCell.h"
#import "SpecialNewsViewTextCell.h"

@interface SpecialNewsBaseView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) CommonPageControlViewSelectBlock pageSelectBlock;
@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, copy) tableViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy) tableViewLoadMoreBlock loadMoreBlock;
@property (nonatomic, copy) tableViewScrollEventlock scrollBlock;

@property (nonatomic, strong) NSArray *classifyArr;
@property (nonatomic, strong) NSArray *listModel;
@property (nonatomic, strong) NSString *noDataImageName;

- (void)endloadEvent;

- (void)loadScrollView;

@end
