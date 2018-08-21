//
//  CarOrderStateView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarOrderStateViewBlock)(void);

@interface CarOrderStateView : UIView

@property (nonatomic, copy) CarOrderStateViewBlock block;
@property (nonatomic, strong) UILabel *stateLab;
@property (nonatomic, strong) UIImageView *companyIcon;
@property (nonatomic, strong) UILabel *companyName;
@property (nonatomic, strong) UILabel *moneyLab;

@end
