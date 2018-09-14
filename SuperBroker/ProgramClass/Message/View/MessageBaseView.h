//
//  MessageBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageBaseViewCell.h"

@interface MessageBaseView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) CommonPageControlViewSelectBlock pageSelectBlock;
@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, copy) tableViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy) tableViewLoadMoreBlock loadMoreBlock;
@property (nonatomic, strong) NSMutableArray *systemNoticeList;
@property (nonatomic, strong) NSMutableArray *wealthNoticeList;
@property (nonatomic) NSInteger segmentIndex;
@property (nonatomic, strong) NSString *noDataImageName;

- (void)reloadTableView;
- (void)endloadEvent;

@end
