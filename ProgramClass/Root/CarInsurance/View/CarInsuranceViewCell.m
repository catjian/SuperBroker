//
//  CarInsuranceViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceViewCell.h"

@implementation CarInsuranceViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.contentView addSubview:self.imageView];
        [self.layer setBorderWidth:1];
        [self.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    }
    return self;
}

@end
