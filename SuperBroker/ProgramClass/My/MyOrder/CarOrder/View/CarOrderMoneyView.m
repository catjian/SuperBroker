//
//  CarOrderMoneyView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderMoneyView.h"

@implementation CarOrderMoneyView
{
    UIView *m_secLineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGSize size = CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12+83));
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
        
        UIStackView *view = [[UIStackView alloc] initWithFrame:CGRectMake(DIF_PX(20), line2.bottom, self.width-DIF_PX(40), DIF_PX(82))];
        [view setAxis:UILayoutConstraintAxisVertical];
        [view setAlignment:UIStackViewAlignmentFill];
        [view setDistribution:UIStackViewDistributionFillEqually];
        [view setSpacing:0];
        [view addArrangedSubview:[self FristLineView]];
        [view addArrangedSubview:[self SecondLineView]];
        [self addSubview:view];
    }
    return self;
}

- (UIView *)FristLineView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width-DIF_PX(40), DIF_PX(40))];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width-DIF_PX(40), DIF_PX(40))];
    [title setFont:DIF_UIFONTOFSIZE(13)];
    [title setTextColor:DIF_HEXCOLOR(@"999999")];
    [title setText:@"车险保单金额："];
    [view addSubview:title];
    
    self.contentFriLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width-DIF_PX(60), DIF_PX(40))];
    [self.contentFriLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.contentFriLab setTextColor:DIF_HEXCOLOR(@"999999")];
    [self.contentFriLab setTextAlignment:NSTextAlignmentRight];
    [view addSubview:self.contentFriLab];
    
    return view;
}

- (UIView *)SecondLineView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width-DIF_PX(40), DIF_PX(40))];
    [title setFont:DIF_UIFONTOFSIZE(13)];
    [title setTextColor:DIF_HEXCOLOR(@"999999")];
    [title setText:@"消费券："];
    [view addSubview:title];
    
    self.contentSecLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width-DIF_PX(60), DIF_PX(40))];
    [self.contentSecLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.contentSecLab setTextAlignment:NSTextAlignmentRight];
    [self.contentSecLab setText:@"可使用消费券"];
    [self.contentSecLab setTextColor:DIF_HEXCOLOR(@"999999")];
    [view addSubview:self.contentSecLab];
    
    UIImageView *right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右括号"]];
    [right setCenterY:title.height/2];
    [right setRight:title.width];
    [view addSubview:right];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:title.frame];
    [btn setBackgroundColor:DIF_HEXCOLOR(@"")];
    [btn addTarget:self action:@selector(selectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    m_secLineView = view;
    return m_secLineView;
}

- (void)selectButtonEvent:(UIButton *)btn
{
    if(self.selectBlock)
    {
        self.selectBlock();
    }
}

- (void)hideSecondLab
{
    [m_secLineView setHidden:YES];
    self.height -= DIF_PX(82/2);
}
@end
