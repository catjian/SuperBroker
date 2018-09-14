//
//  CarOrderCancelButtonView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarOrderCancelButtonBlock)(void);

@interface CarOrderCancelButtonView : UIView

@property (nonatomic,copy) CarOrderCancelButtonBlock block;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *cancelBtn;

@end
