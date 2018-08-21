//
//  InsuranceCompanyViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^InsuranceCompanyViewControllerBlock)(NSArray *);

@interface InsuranceCompanyViewController : BaseViewController

@property (nonatomic, copy) InsuranceCompanyViewControllerBlock block;
@property (nonatomic, copy) NSString *compIdStr;

@end
