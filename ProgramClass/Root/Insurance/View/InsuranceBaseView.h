//
//  InsuranceBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceBaseView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *insuranceDataArray;
@property (nonatomic, copy) tableViewScrollEventlock scrollBlock;
@property (nonatomic, copy) CommonPageControlViewSelectBlock topSelectBlock;

@end
