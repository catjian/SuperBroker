//
//  CarOrderTowButtonView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarOrderTowButtonViewBtnlock)(BOOL isSuccess);

@interface CarOrderTowButtonView : UIView

@property (nonatomic, copy) CarOrderTowButtonViewBtnlock buttonBlock;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *successBtn;

@end
