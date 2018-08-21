//
//  InsuranceCompanyBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceCompanyViewCell.h"

typedef void(^InsuranceCompanyBaseViewBlock)(NSArray *);

@interface InsuranceCompanyBaseView : UIView

@property (nonatomic, copy) InsuranceCompanyBaseViewBlock block;
@property (nonatomic, strong) NSArray *companyArr;
@property (nonatomic, copy) NSString *compIdStr;

@end
