//
//  InsuranceBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceViewCell.h"

@interface InsuranceBaseView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, copy) tableViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy) tableViewLoadMoreBlock loadMoreBlock;
@property (nonatomic, copy) tableViewScrollEventlock scrollBlock;
@property (nonatomic, copy) CommonPageControlViewSelectBlock topSelectBlock;
@property (nonatomic, strong) InsuranceProductModel *insuranceProductModel;
@property (nonatomic, strong) NSArray *insuranceProductModelArr;
@property (nonatomic, strong) NSString *noDataImageName;

- (void)refreshTableView;
- (void)uploadTopButtonStatusWithType:(BOOL)typeOn Comp:(BOOL)comON Age:(BOOL)ageOn Screen:(BOOL)screenOn;

@end
