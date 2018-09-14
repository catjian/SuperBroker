//
//  CarOrderMoneyButtonView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarOrderMoneyButtonViewBtnlock)(void);

@interface CarOrderMoneyButtonView : UIView

@property (nonatomic, copy) CarOrderMoneyButtonViewBtnlock buttonBlock;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UIButton *successBtn;
@property (nonatomic) BOOL showButton;

@end
