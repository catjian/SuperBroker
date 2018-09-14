//
//  LoanScreenViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LoanScreenViewControllerBlock)(NSArray *);

@interface LoanScreenViewController : BaseViewController

@property (nonatomic, copy) LoanScreenViewControllerBlock block;
@property (nonatomic, strong) NSArray *screenDataArr;
@property (nonatomic, copy) NSString *screenIdStr;
@property (nonatomic) BOOL isSingle;

@end
