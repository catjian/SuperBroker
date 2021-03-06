//
//  InsuranceAgeViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceAgeViewCell.h"

@implementation InsuranceAgeViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.layer setBorderWidth:1];
        [self.layer setCornerRadius:5];
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?10:12)];
        [self.titleLab setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}


@end
