//
//  ScreenViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ScreenViewControllerBlock)(NSArray *,NSArray *);

@interface ScreenViewController : BaseViewController

@property (nonatomic, copy) ScreenViewControllerBlock block;
@property (nonatomic, copy) NSString *orderTypeStr;
@property (nonatomic, copy) NSString *consumptionTypeStr;

@end
