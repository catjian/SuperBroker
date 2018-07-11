//
//  BaseTableView.h
//  uavsystem
//
//  Created by zhang_jian on 16/7/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tableViewTouchBeginEventBlock)(UITableView *tableView, NSSet *touches, UIEvent *event);
typedef void(^tableViewTouchEndEventBlock)(UITableView *tableView, NSSet *touches, UIEvent *event);
typedef void(^tableViewTouchMoveEventBlock)(UITableView *tableView, NSSet *touches, UIEvent *event);
typedef void(^tableViewTouchCancelEventBlock)(UITableView *tableView, NSSet *touches, UIEvent *event);
typedef void(^tableViewScrollEventlock)(UITableView *tableView, UIScrollView *scrollView);

typedef void(^tableViewSelectRowAtIndexPathBlock)(NSIndexPath *indexPath, id model);

typedef void(^tableViewHeaderRefreshBlock)(void);
typedef void(^tableViewLoadMoreBlock)(NSInteger page);

@interface BaseTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, copy, readwrite) tableViewTouchBeginEventBlock touchBeginBlock;
@property (nonatomic, copy, readwrite) tableViewTouchEndEventBlock touchEndBlock;
@property (nonatomic, copy, readwrite) tableViewTouchMoveEventBlock touchMoveBlock;
@property (nonatomic, copy, readwrite) tableViewTouchCancelEventBlock touchCancelBlock;
@property (nonatomic, copy, readwrite) tableViewScrollEventlock scrollBlock;

@property (nonatomic, copy, readwrite) tableViewSelectRowAtIndexPathBlock selectBlock;

@property (nonatomic, copy, readwrite) tableViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy, readwrite) tableViewLoadMoreBlock loadMoreBlock;

- (void)refreshAction;

- (void)loadMoreAction;

- (void)endRefresh;

@end
