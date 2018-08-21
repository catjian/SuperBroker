//
//  RootViewHotCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewHotCell.h"

@implementation RootViewHotCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-DIF_PX(160))/2, 13,
                                                                       DIF_PX(160), DIF_PX(100))];
        [self.contentView addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(12, self.imageView.bottom+DIF_PX(5), self.width-24, DIF_PX(20))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#017aff")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.titleLab];
        
        self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom+DIF_PX(4), self.titleLab.width, DIF_PX(15))];
        [self.detailLab setTextColor:DIF_HEXCOLOR(@"#999999")];
        [self.detailLab setFont:DIF_DIFONTOFSIZE(10)];
        [self.contentView addSubview:self.detailLab];
        
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(self.detailLab.left, self.detailLab.bottom+DIF_PX(4), self.detailLab.width, DIF_PX(15))];
        [self.moneyLab setTextColor:DIF_HEXCOLOR(@"#ff5000")];
        [self.moneyLab setFont:DIF_DIFONTOFSIZE(10)];
        [self.contentView addSubview:self.moneyLab];
    }
    return self;
}

@end
