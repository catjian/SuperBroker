//
//  InsuranceTypesBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuranceTypesViewCell.h"

typedef void(^InsuranceTypesBaseViewBlock)(NSArray *);

@interface InsuranceTypesBaseView : UIView

@property (nonatomic, copy) InsuranceTypesBaseViewBlock block;
@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, copy) NSString *speciesIdStr;

@end
