//
//  CarOrderMoneyButtonView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderMoneyButtonView.h"

@implementation CarOrderMoneyButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(50));
    frame.size = size;
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 1)];
        [line1 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line1];
        
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        
        [self createContentView];
    }
    return self;
}

- (void)createContentView
{
    self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 1, self.width-24, DIF_PX(49))];
    [self.moneyLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [self.moneyLab setFont:DIF_UIFONTOFSIZE(13)];
    [self addSubview:self.moneyLab];
    
    self.successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.successBtn setFrame:CGRectMake(0, 0, DIF_PX(150), DIF_PX(49))];
    [self.successBtn setRight:self.width];
    [self.successBtn setBackgroundColor:DIF_HEXCOLOR(@"017aff")];
    [self.successBtn setTitleColor:DIF_HEXCOLOR(@"ffffff") forState:UIControlStateNormal];
    [self.successBtn addTarget:self action:@selector(selectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.successBtn setTag:1001];
    [self addSubview:self.successBtn];
}

- (void)setShowButton:(BOOL)showButton
{
    [[self viewWithTag:1001] setHidden:!showButton];
}

- (void)selectButtonEvent:(UIButton *)btn
{
    if(self.buttonBlock)
    {
        self.buttonBlock();
    }
}

@end
