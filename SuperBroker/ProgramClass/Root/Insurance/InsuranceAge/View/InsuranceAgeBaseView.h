//
//  InsuranceAgeBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InsuranceAgeBaseViewBlock)(NSArray *);

@interface InsuranceAgeBaseView : UIView

@property (nonatomic, copy) InsuranceAgeBaseViewBlock block;
@property (nonatomic, copy) NSString *ageStr;

@end
