//
//  CarOrderManagerView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderManagerView.h"

@implementation CarOrderManagerView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12+392));
    frame.size = size;
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 1)];
        [line1 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line1];
        
        UIView *lineSpace = [[UIView alloc] initWithFrame:CGRectMake(0, line1.bottom, line1.width, DIF_PX(10))];
        [lineSpace setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
        [self addSubview:lineSpace];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, lineSpace.bottom, size.width, 1)];
        [line2 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line2];
        
        [self createContentView];
    }
    return self;
}

- (void)createContentView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(12), self.width, DIF_PX(392))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self addSubview:view];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, DIF_PX(45), view.width, DIF_PX(20))];
    [titleLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [titleLab setFont:DIF_UIFONTOFSIZE(15)];
    [titleLab setTextAlignment:NSTextAlignmentCenter];
    [titleLab setText:@"本保单经理微信联系方式"];
    [view addSubview:titleLab];
    
    self.managerPhone = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLab.bottom+DIF_PX(10), view.width, DIF_PX(15))];
    [self.managerPhone setTextColor:DIF_HEXCOLOR(@"333333")];
    [self.managerPhone setFont:DIF_UIFONTOFSIZE(13)];
    [self.managerPhone setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:self.managerPhone];
    
    self.managerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(82), self.managerPhone.bottom+DIF_PX(35), DIF_PX(50), DIF_PX(50))];
    [view addSubview:self.managerIcon];
    [self.managerIcon setHidden:YES];
    
    self.managerName = [[UILabel alloc] initWithFrame:CGRectMake(self.managerIcon.right+DIF_PX(8), self.managerIcon.top,
                                                                 view.width-self.managerIcon.right-DIF_PX(20), self.managerIcon.height)];
    [self.managerName setTextColor:DIF_HEXCOLOR(@"333333")];
    [self.managerName setFont:DIF_UIFONTOFSIZE(13)];
    [view addSubview:self.managerName];
    [self.managerName setHidden:YES];
    
    self.managerQRImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.managerPhone.bottom+DIF_PX(25), DIF_PX(180), DIF_PX(180))];
    [self.managerQRImage setCenterX:view.width/2];
    [view addSubview:self.managerQRImage];
}

@end
