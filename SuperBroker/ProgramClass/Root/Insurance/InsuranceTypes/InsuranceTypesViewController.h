//
//  InsuranceTypesViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^InsuranceTypesViewControllerBlock)(NSArray *);

@interface InsuranceTypesViewController : BaseViewController

@property (nonatomic, copy) InsuranceTypesViewControllerBlock block;
@property (nonatomic, copy) NSString *speciesIdStr;

@end
