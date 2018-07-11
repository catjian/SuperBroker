//
//  InsuranceTypesViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceTypesViewCell.h"

@implementation InsuranceTypesViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"#000000")];
        [self.titleLab setFont:DIF_DIFONTOFSIZE(is_iPhone5AndEarly?10:12)];
        [self.titleLab setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

@end
