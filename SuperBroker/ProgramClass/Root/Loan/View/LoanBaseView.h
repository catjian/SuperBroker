//
//  LoanBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/29.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanTableViewCell.h"

@interface LoanBaseView : UIView<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, copy) tableViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy) tableViewLoadMoreBlock loadMoreBlock;
@property (nonatomic, copy) tableViewScrollEventlock scrollBlock;
@property (nonatomic, copy) CommonPageControlViewSelectBlock topSelectBlock;
@property (nonatomic, strong) NSString *noDataImageName;
@property (nonatomic, strong) LoanproductModel *loanProModel;
@property (nonatomic, strong) NSArray *loanProModelArr;

- (void)refreshTableView;
- (void)uploadTopButtonStatusWithType:(BOOL)typeOn Comp:(BOOL)comON Age:(BOOL)ageOn Screen:(BOOL)screenOn;

@end
