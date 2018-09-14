//
//  MyOrderListViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyOrderListViewCell.h"

@implementation MyOrderListViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 95;
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0,
                                                                       DIF_PX(84), DIF_PX(63))];
        [self.iconImage setCenterY:DIF_PX(95/2)];
        [self.iconImage.layer setBorderWidth:1];
        [self.iconImage.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.contentView addSubview:self.iconImage];
        
        self.statusLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(80), self.cellHeight)];
        [self.statusLab setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [self.statusLab setCenterY:self.cellHeight/2];
        [self.statusLab setTextColor:DIF_HEXCOLOR(@"#999999")];
        [self.statusLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.statusLab setTextAlignment:NSTextAlignmentRight];
        [self.statusLab setNumberOfLines:0];
        [self.statusLab setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.statusLab];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImage.right+DIF_PX(15), self.iconImage.top, self.statusLab.left-self.iconImage.right-DIF_PX(30), DIF_PX(20))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(15)];
        [self.contentView addSubview:self.titleLab];
        
        
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom+DIF_PX(17), self.titleLab.width, DIF_PX(15))];
        [self.moneyLab setTextColor:DIF_HEXCOLOR(@"#ff5000")];
        [self.moneyLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.moneyLab];
        
        self.dateLab = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLab.left, self.moneyLab.bottom+DIF_PX(4), self.moneyLab.width, DIF_PX(15))];
        [self.dateLab setTextColor:DIF_HEXCOLOR(@"#999999")];
        [self.dateLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.dateLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 94, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

@end
