//
//  CarOwnerInfoview.m
//  SuperBroker
//  有三行内容和一个title的view
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderThreeLineContentView.h"

@implementation CarOrderThreeLineContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12+50+1+73));
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
        
        UIView *titleView = [self createTitleViewWithView:line2];
        [self addSubview:titleView];
        
        [self createContentViewWithView:titleView];
    }
    return self;
}

- (UIView *)createTitleViewWithView:(UIView *)topView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom, topView.width, DIF_PX(50))];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_PX(2), DIF_PX(13))];
    [lineV setBackgroundColor:DIF_HEXCOLOR(@"017AFF")];
    [lineV setCenterY:view.height/2];
    [view addSubview:lineV];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(lineV.right+DIF_PX(5), 0, view.width-DIF_PX(50), view.height)];
    [self.titleLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.titleLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [view addSubview:self.titleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
    [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:line];
    return view;
}

- (void)createContentViewWithView:(UIView *)topView
{
    UIStackView *view = [[UIStackView alloc] initWithFrame:CGRectMake(DIF_PX(20), topView.bottom, self.width-DIF_PX(40), DIF_PX(72))];
    [view setAxis:UILayoutConstraintAxisVertical];
    [view setAlignment:UIStackViewAlignmentFill];
    [view setDistribution:UIStackViewDistributionFillEqually];
    [view setSpacing:0];
    
    self.contentFriLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentFriLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.contentFriLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [view addArrangedSubview:self.contentFriLab];
    self.contentSecLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentSecLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.contentSecLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [view addArrangedSubview:self.contentSecLab];
    self.contentThrLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentThrLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.contentThrLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [view addArrangedSubview:self.contentThrLab];
    [self addSubview:view];
}

@end
