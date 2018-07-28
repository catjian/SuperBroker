//
//  CarOrderDateView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderDateStyleOneView.h"

@implementation CarOrderDateStyleOneView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12+1+73));
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
        
        UIStackView *view = [[UIStackView alloc] initWithFrame:CGRectMake(DIF_PX(20), line2.bottom, self.width-DIF_PX(40), DIF_PX(72))];
        [view setAxis:UILayoutConstraintAxisVertical];
        [view setAlignment:UIStackViewAlignmentFill];
        [view setDistribution:UIStackViewDistributionFillEqually];
        [view setSpacing:0];
        
        self.contentFriLab = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentFriLab setFont:DIF_UIFONTOFSIZE(13)];
        [self.contentFriLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [view addArrangedSubview:self.contentFriLab];
        self.contentSecLab = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentSecLab setFont:DIF_UIFONTOFSIZE(13)];
        [self.contentSecLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [view addArrangedSubview:self.contentSecLab];
        self.contentThrLab = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentThrLab setFont:DIF_UIFONTOFSIZE(13)];
        [self.contentThrLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [view addArrangedSubview:self.contentThrLab];
        [self addSubview:view];
    }
    return self;
}

@end
