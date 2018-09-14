//
//  UIView+CornerSquare.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (UIView_CornerSquare)


/**
 添加带圆角的虚线

 @param corner 圆角
 @param width 线宽
 @param pattern @[@1,@2] 第一个是 线条长度 第二个是间距 nil时为实线
 @param color 颜色
 */
- (void)setlayerCornerSquareWithCornerRadius:(CGFloat)corner
                                   lineWidth:(CGFloat)width
                                 DashPattern:(NSArray *)pattern
                                       color:(UIColor *)color;

@end
