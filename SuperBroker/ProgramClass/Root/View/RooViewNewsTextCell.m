//
//  RooViewNewsTextCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RooViewNewsTextCell.h"

@implementation RooViewNewsTextCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, DIF_SCREEN_WIDTH-24, 35)];
        [self.title setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.title setFont:DIF_UIFONTOFSIZE(15)];
        [self.title setNumberOfLines:0];
        [self.title setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.title];
        
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(12, self.title.bottom+10, DIF_SCREEN_WIDTH-24, 50)];
        [self.detail setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.detail setFont:DIF_UIFONTOFSIZE(12)];
        [self.detail setNumberOfLines:0];
        [self.detail setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.detail];
        
        self.company = [[UILabel alloc] initWithFrame:CGRectMake(12, self.detail.bottom+10, DIF_SCREEN_WIDTH-24, 15)];
        [self.company setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.company setFont:DIF_UIFONTOFSIZE(10)];
        [self.company setNumberOfLines:0];
        [self.company setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.company];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 144, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

@end
