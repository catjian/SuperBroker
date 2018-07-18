//
//  CommonPageControlView.m
//  EAVisionSurveyTool
//
//  Created by zhang_jian on 2018/4/8.
//  Copyright © 2018年 jian zhang. All rights reserved.
//

#import "CommonPageControlView.h"

@interface CommonPageControlView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation CommonPageControlView
{
    UIScrollView *m_scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [m_scrollView setShowsHorizontalScrollIndicator:NO];
        [m_scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:m_scrollView];
        [self createItemWithData:titles];
    }
    return self;
}

- (void)createItemWithData:(NSArray<NSString *> *)data
{
    for (NSInteger i = 0; i < data.count; i ++)
    {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(12+i*30+i*38, 0, 30, self.height);
        label.text = data[i];
        label.tag = i;
        label.font = DIF_DIFONTOFSIZE(14);
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0)
        {
            label.textColor = DIF_HEXCOLOR(@"#017aff");
            CGRect attrsRect = [[data firstObject] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{NSFontAttributeName : label.font}
                                                  context:nil];
            self.indicatorView.size = CGSizeMake(attrsRect.size.width, 1);
            self.indicatorView.centerX = label.centerX;
            self.indicatorView.bottom = self.height - 1;
            [m_scrollView addSubview:self.indicatorView];
        }
        else
        {
            label.textColor = DIF_HEXCOLOR(@"#333333");
        }
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelAction:)]];
        [m_scrollView addSubview:label];
    }
    if ((data.count*30+data.count*38) > DIF_SCREEN_WIDTH)
    {
        [m_scrollView setContentSize:CGSizeMake(data.count*27+data.count*38, m_scrollView.height)];
    }
}

- (void)labelAction:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(selectedIndex:)]) {
        [_delegate selectedIndex:index];
    }
    if (self.selectBlock)
    {
        self.selectBlock(index);
    }
    for (UIView *view in m_scrollView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            if (label.tag == index) {
                UIView *indicatorView = [m_scrollView viewWithTag:10];
                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    label.textColor = DIF_HEXCOLOR(@"#017aff");
                    CGRect attrsRect = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                             attributes:@{NSFontAttributeName : label.font}
                                                                context:nil];
                    indicatorView.size = CGSizeMake(attrsRect.size.width, 1);
                    indicatorView.centerX = label.centerX;
                    indicatorView.bottom = self.height - 1;
                } completion:NULL];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    label.textColor = DIF_HEXCOLOR(@"#333333");
                }];
            }
        }
    }
}


- (UIView *)indicatorView
{
    if (!_indicatorView)
    {
        _indicatorView = [UIView new];
        _indicatorView.tag = 10;
        _indicatorView.backgroundColor = DIF_HEXCOLOR(@"#017aff");
    }
    return _indicatorView;
}

@end
