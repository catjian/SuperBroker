//
//  RootViewSecondFloorCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/6.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewSecondFloorCell.h"

@implementation RootViewSecondFloorCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-DIF_PX(42))/2, 10,
                                                                       DIF_PX(42), DIF_PX(42))];
        [self.contentView addSubview:self.imageView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.bottom+DIF_PX(12), self.width, DIF_PX(15))];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?12:14)];
        [self.titleLab setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLab];
        
        self.charLab = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.right, self.imageView.top-8, 30, 15)];
        [self.charLab setText:@"新！"];
        [self.charLab setTextColor:[UIColor redColor]];
        [self.charLab setFont:DIF_DIFONTOFSIZE(13)];
        [self.contentView addSubview:self.charLab];
    }
    return self;
}

@end
