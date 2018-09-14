//
//  ScreenBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreehnBaseViewCell.h"

typedef void(^ScreenBaseViewBlock)(NSArray *);

@interface ScreenBaseView : UIView

@property (nonatomic, copy) ScreenBaseViewBlock block;
@property (nonatomic, strong) NSArray *screenArr;
@property (nonatomic, copy) NSString *orderTypeStr;
@property (nonatomic, copy) NSString *consumptionTypeStr;

@end
