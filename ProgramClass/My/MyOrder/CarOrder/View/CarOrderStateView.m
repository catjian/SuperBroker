//
//  CarOrderStateView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderStateView.h"

@implementation CarOrderStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12+50+1+95));
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
        
        UIView *stateView = [self createStateViewWithView:line2];
        [self addSubview:stateView];
        
        [self createCompanyInfoViewWithView:stateView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:self.bounds];
        [btn addTarget:self action:@selector(ViewButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (UIView *)createStateViewWithView:(UIView *)topView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom, topView.width, DIF_PX(50))];
    
    self.stateLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, view.width-DIF_PX(24), view.height)];
    [self.stateLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.stateLab setTextColor:DIF_HEXCOLOR(@"FF5000")];
    [view addSubview:self.stateLab];
    
    self.moneyLab = [[UILabel alloc] initWithFrame:self.stateLab.frame];
    [self.moneyLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.moneyLab setTextColor:DIF_HEXCOLOR(@"FF5000")];
    [self.moneyLab setTextAlignment:NSTextAlignmentRight];
    [view addSubview:self.moneyLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
    [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:line];
    return view;
}

- (void)createCompanyInfoViewWithView:(UIView *)topView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom, topView.width, DIF_PX(95))];
    [self addSubview:view];
    
    self.companyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_PX(84), DIF_PX(63))];
    [self.companyIcon setCenterY:view.height/2];
    [view addSubview:self.companyIcon];
    
    UIImageView *rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右括号"]];
    [rightIcon setCenterY:view.height/2];
    [rightIcon setRight:view.width-DIF_PX(12)];
    [view addSubview:rightIcon];
    
    self.companyName = [[UILabel alloc] initWithFrame:CGRectMake(self.companyIcon.right+DIF_PX(16), DIF_PX(29), rightIcon.left-self.companyIcon.right-DIF_PX(32), DIF_PX(16))];
    [self.companyName setTextColor:DIF_HEXCOLOR(@"333333")];
    [self.companyName setFont:DIF_UIFONTOFSIZE(15)];
    [view addSubview: self.companyName];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.companyName.left, self.companyName.bottom+DIF_PX(11), self.companyName.width, DIF_PX(14))];
    [title setTextColor:DIF_HEXCOLOR(@"999999")];
    [title setFont:DIF_UIFONTOFSIZE(13)];
    [title setText:@"点击查看投保详情"];
    [view addSubview:title];
}

- (void)ViewButtonEvent
{
    if (self.block)
    {
        self.block();
    }
}

@end
