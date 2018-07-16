//
//  RooViewNewsCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RooViewNewsCell.h"

@implementation RooViewNewsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0,
                                                                       DIF_PX(84), DIF_PX(63))];
        [self.imageView setCenterY:DIF_PX(95/2)];
        [self.contentView addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.right+DIF_PX(15), self.imageView.top, self.width-self.imageView.right-DIF_PX(30), DIF_PX(20))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(15)];
        [self.contentView addSubview:self.titleLab];
        
        self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom+DIF_PX(17), self.titleLab.width-DIF_PX(100), DIF_PX(15))];
        [self.detailLab setTextColor:DIF_HEXCOLOR(@"#999999")];
        [self.detailLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.detailLab];
        
        self.companyLab = [[UILabel alloc] initWithFrame:CGRectMake(self.detailLab.left, self.detailLab.bottom+DIF_PX(4), self.detailLab.width, DIF_PX(15))];
        [self.companyLab setTextColor:DIF_HEXCOLOR(@"#ff5000")];
        [self.companyLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.companyLab];
        
        self.readNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(80), DIF_PX(15))];
        [self.readNumLab setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [self.readNumLab setBottom:self.companyLab.bottom];
        [self.readNumLab setTextColor:DIF_HEXCOLOR(@"#999999")];
        [self.readNumLab setFont:DIF_DIFONTOFSIZE(10)];
        [self.readNumLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.readNumLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 94, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

@end
