//
//  InsuranceAgeViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^InsuranceAgeViewControllerBlock)(NSArray *);

@interface InsuranceAgeViewController : BaseViewController

@property (nonatomic, copy) InsuranceAgeViewControllerBlock block;
@property (nonatomic, copy) NSString *ageStr;

@end
