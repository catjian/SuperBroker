//
//  RootViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewCell.h"

@implementation RootViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-DIF_PX(67))/2, 24,
                                                                       DIF_PX(67), DIF_PX(67))];
        [self.contentView addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.bottom+DIF_PX(6), self.width, DIF_PX(24))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?12:15)];
        [self.titleLab setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

@end
