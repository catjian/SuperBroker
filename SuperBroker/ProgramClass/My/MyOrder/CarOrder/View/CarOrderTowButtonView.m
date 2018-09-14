//
//  CarOrderTowButtonView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderTowButtonView.h"

@implementation CarOrderTowButtonView

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
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setFrame:CGRectMake(0, 1, DIF_PX(150), DIF_PX(49))];
    [self.cancelBtn setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self.cancelBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(selectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTag:1000];
    [self addSubview:self.cancelBtn];
    
    self.successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.successBtn setFrame:CGRectMake(0, 1, DIF_PX(150), DIF_PX(49))];
    [self.successBtn setRight:self.width];
    [self.successBtn setTitleColor:DIF_HEXCOLOR(@"ffffff") forState:UIControlStateNormal];
    [self.successBtn setBackgroundColor:DIF_HEXCOLOR(@"017aff")];
    [self.successBtn addTarget:self action:@selector(selectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.successBtn setTag:1001];
    [self addSubview:self.successBtn];
}

- (void)selectButtonEvent:(UIButton *)btn
{
    if(self.buttonBlock)
    {
        self.buttonBlock(btn.tag==1001?YES:NO);
    }
}

@end
