//
//  SpecialNewsViewTextCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/19.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsViewTextCell.h"

@implementation SpecialNewsViewTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 145;
        
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
        
        self.company = [[UILabel alloc] initWithFrame:CGRectMake(12, self.detail.bottom+20, DIF_SCREEN_WIDTH-24, 15)];
        [self.company setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.company setFont:DIF_UIFONTOFSIZE(15)];
        [self.company setNumberOfLines:0];
        [self.company setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.title];
    }
    return self;
}

@end
