//
//  UIView+CornerSquare.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "UIView+CornerSquare.h"

@implementation UIView (UIView_CornerSquare)

- (void)setlayerCornerSquareWithCornerRadius:(CGFloat)corner
                                   lineWidth:(CGFloat)width
                                 DashPattern:(NSArray *)pattern
                                       color:(UIColor *)color
{
    if (!pattern)
    {
        [self setlayerCornerSquareWithCornerRadius:corner lineWidth:width color:color];
        return;
    }
    UIBezierPath *maskPath= [[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(corner, corner)] bezierPathByReversingPath];
    CAShapeLayer *border = [CAShapeLayer layer];
    // 线条颜色
    border.strokeColor = color.CGColor;
    border.masksToBounds = YES;
    
    border.fillColor = nil;
    border.path = maskPath.CGPath;
    border.frame = self.bounds;
    
    border.lineWidth = width;
    border.lineCap = @"square";
    border.lineDashPattern = pattern;
    [self.layer addSublayer:border];
}

- (void)setlayerCornerSquareWithCornerRadius:(CGFloat)corner
                                   lineWidth:(CGFloat)width
                                       color:(UIColor *)color
{
    [self.layer setCornerRadius:corner];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
    [self.layer setMasksToBounds:YES];
}

@end
