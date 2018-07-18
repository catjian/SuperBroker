//
//  SpecialNewsViewMoreImageCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/19.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsViewMoreImageCell.h"

@implementation SpecialNewsViewMoreImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 140;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, DIF_SCREEN_WIDTH-24, 16)];
        [self.title setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.title setFont:DIF_UIFONTOFSIZE(15)];
        [self.contentView addSubview:self.title];
        
        self.pic1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, self.title.bottom+10, 107, 63)];
        [self.contentView addSubview:self.pic1];
        self.pic2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.pic1.right+15, self.pic1.top, 107, 63)];
        [self.contentView addSubview:self.pic2];
        self.pic3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.pic2.right+15, self.pic2.top, 107, 63)];
        [self.contentView addSubview:self.pic3];
        
        self.company = [[UILabel alloc] initWithFrame:CGRectMake(12, self.pic1.bottom+10, DIF_SCREEN_WIDTH-24, 15)];
        [self.company setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.company setFont:DIF_UIFONTOFSIZE(15)];
        [self.company setNumberOfLines:0];
        [self.company setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.title];
    }
    return self;
}

@end
