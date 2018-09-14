//
//  CommonADAutoView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CommonADAutoView.h"

@implementation CommonADAutoView
{
    UIScrollView *m_BaseView;
    UIPageControl *m_PageCon;
    BOOL m_Auto;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_BaseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [m_BaseView setPagingEnabled:YES];
        [self addSubview:m_BaseView];
        m_PageCon = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height-40, self.width, 30)];
        [self addSubview:m_PageCon];
    }
    return self;
}

- (void)setPicArr:(NSArray *)picArr
{
    m_Auto = NO;
    _picArr = picArr;
    [self createContentView];
    [m_PageCon setNumberOfPages:picArr.count];
    [m_PageCon setCurrentPage:0];
}

- (void)createContentView
{
    for(UIView *subView in m_BaseView.subviews)
    {
        [subView removeFromSuperview];
    }
    if (self.picArr.count == 0)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [imageView setImage:[UIImage imageNamed:@"轮播图-banner01"]];
        [m_BaseView addSubview:imageView];
    }
    for(int i = 0; i < self.picArr.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.width, 0, self.width, self.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.picArr[i]] placeholderImage:[UIImage imageNamed:@"轮播图-banner01"]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:100+i];
        [btn setFrame:imageView.frame];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(selectImageButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [m_BaseView addSubview:imageView];
        [m_BaseView addSubview:btn];
    }
    [m_BaseView setContentSize:CGSizeMake(self.width*self.picArr.count, self.height)];
    m_Auto = YES;
    [self performSelector:@selector(autoChangePage) withObject:nil afterDelay:3];
}

- (void)autoChangePage
{
    if (!m_Auto) return;
    NSInteger nowPage = m_PageCon.currentPage;
    nowPage++;
    if (nowPage >= self.picArr.count)
    {
        [m_PageCon setCurrentPage:0];
        [m_BaseView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        [m_PageCon setCurrentPage:nowPage];
        [m_BaseView setContentOffset:CGPointMake(nowPage*self.width, 0) animated:YES];
    }
    [self performSelector:@selector(autoChangePage) withObject:nil afterDelay:3];
}

- (void)selectImageButtonEvent:(UIButton *)btn
{
    if(self.selectBlock)
    {
        self.selectBlock(btn.tag-100);
    }
}

@end
