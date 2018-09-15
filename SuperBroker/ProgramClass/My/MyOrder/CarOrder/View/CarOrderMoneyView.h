//
//  CarOrderMoneyView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarOrderMoneyViewSelectBlock)(void);

@interface CarOrderMoneyView : UIView

@property (nonatomic, copy) CarOrderMoneyViewSelectBlock selectBlock;
@property (nonatomic, strong) UILabel *contentFriLab;
@property (nonatomic, strong) UILabel *contentSecLab;

- (void)hideSecondLab;

@end
