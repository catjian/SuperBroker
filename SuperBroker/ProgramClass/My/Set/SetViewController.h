//
//  SetViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SetViewControllerLogoutBlock)(void);

@interface SetViewController : BaseViewController

@property (nonatomic, copy) SetViewControllerLogoutBlock loblock;

@end
