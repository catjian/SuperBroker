//
//  SpecialNewsBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsBaseView.h"

@implementation SpecialNewsBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CommonPageControlView *pageView = [[CommonPageControlView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(60))
                                                                                titles:@[@"车险",@"推荐",@"理念",@"签单",@"产品",@"问答"]];
        [self addSubview:pageView];
        UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
        [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:lineT];
        UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, pageView.height-1, DIF_SCREEN_WIDTH, 1)];
        [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:lineB];
    }
    return self;
}

@end
