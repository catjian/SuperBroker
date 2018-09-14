//
//  RootViewLoanCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/29.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewLoanCell.h"

@implementation RootViewLoanCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13, DIF_PX(36), DIF_PX(36))];
        [self.imageView.layer setCornerRadius:5];
        [self.imageView.layer setMasksToBounds:YES];
        [self.imageView.layer setBorderWidth:1];
        [self.imageView.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.contentView addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.right+13, self.imageView.top, self.width-self.imageView.right-13, DIF_PX(18))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.titleLab];
        
        self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, self.titleLab.bottom, self.titleLab.width, DIF_PX(18))];
        [self.detailLab setTextColor:DIF_HEXCOLOR(@"#999999")];
        [self.detailLab setFont:DIF_DIFONTOFSIZE(10)];
        [self.contentView addSubview:self.detailLab];
    }
    return self;
}

@end
