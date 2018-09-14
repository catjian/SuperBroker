//
//  CarOrderCancelButtonView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderCancelButtonView.h"

@implementation CarOrderCancelButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12+1+150));
    frame.size = size;
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 1)];
        [line1 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line1];
        
        UIView *lineSpace = [[UIView alloc] initWithFrame:CGRectMake(0, line1.bottom, line1.width, DIF_PX(10))];
        [lineSpace setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
        [self addSubview:lineSpace];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, lineSpace.bottom, size.width, 1)];
        [line2 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line2];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(12), line2.bottom+DIF_PX(15), DIF_PX(13), DIF_PX(13))];
        [icon setImage:[UIImage imageNamed:@"注意"]];
        [self addSubview:icon];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(icon.right+DIF_PX(8), line2.bottom+DIF_PX(15), self.width-icon.right-DIF_PX(16), DIF_PX(30))];
        [self.titleLab setText:@"此订单正在审核，稍后保险经理的联系方式会在此处显示,如有其他问题请联系客服！"];
        [self.titleLab setFont:DIF_UIFONTOFSIZE(12)];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.titleLab setLineBreakMode:NSLineBreakByCharWrapping];
        [self.titleLab setNumberOfLines:0];
        [self addSubview:self.titleLab];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setFrame:CGRectMake(0, self.titleLab.bottom+DIF_PX(57), DIF_PX(293), DIF_PX(45))];
        [self.cancelBtn setCenterX:self.width/2];
        [self.cancelBtn setImage:[UIImage imageNamed:@"取消订单"] forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelBtn];
    }
    return self;
}

- (void)cancelButtonEvent:(UIButton *)btn
{
    if(self.block)
    {
        self.block();
    }
}

@end
