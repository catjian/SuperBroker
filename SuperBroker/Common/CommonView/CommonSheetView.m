//
//  CommonSheetView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CommonSheetView.h"

@implementation CommonSheetView
{
    NSArray *m_sheetTitles;
    BOOL isShowController;
    UIView *m_BtnView;
    
    CommonSheetViewSelectBlock m_Block;
    CGFloat m_btnBackView_height;
}

- (void) initWithSheetTitle:(NSArray *)titles
              ResponseBlock:(CommonSheetViewSelectBlock)block
{
    if ([self init])
    {
        m_Block = block;
        m_sheetTitles = titles;
        m_btnBackView_height = 10+50*titles.count;
        [self setBackgroundColor:[UIColor colorWithRed:0.7556 green:0.7556 blue:0.7556 alpha:0.4]];
        [self setAlpha:0];
        [self initSelectView];
        [self show];
    }
}

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    return self;
}

- (void)initSelectView
{
    DIF_WeakSelf(self);
    m_BtnView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_SCREEN_HEIGHT+(is_iPHONE_X?39:0), DIF_SCREEN_WIDTH, m_btnBackView_height)];
    [m_BtnView setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self addSubview:m_BtnView];
    
    [m_sheetTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DIF_StrongSelf
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, idx*(50)+(idx == 2?10:0), DIF_SCREEN_WIDTH, 50)];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [btn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
        [btn.titleLabel setFont:DIF_UIFONTOFSIZE(18)];
        [btn setTag:idx+100];
        [btn addTarget:weakSelf action:@selector(SelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [strongSelf->m_BtnView addSubview:btn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (idx == 2?(idx*(50)+10):(idx+1)*(49.5)), DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [strongSelf->m_BtnView addSubview:line];
    }];
}

- (void)show
{
    [DIF_APPDELEGATE.window addSubview:self];
    DIF_WeakSelf(self);
    [UIView animateWithDuration:0.5 animations:^{
        DIF_StrongSelf
        [weakSelf setAlpha:1];
        [strongSelf->m_BtnView setTop:strongSelf.bottom-strongSelf->m_btnBackView_height-(is_iPHONE_X?39:0)];
    }];
}

- (void)hide
{
    DIF_WeakSelf(self);
    [UIView animateWithDuration:0.5 animations:^{
        DIF_StrongSelf
        [strongSelf->m_BtnView setTop:DIF_SCREEN_HEIGHT+(is_iPHONE_X?39:0)];
        [weakSelf setAlpha:0];
    } completion:^(BOOL finished) {
        DIF_StrongSelf
        [strongSelf removeFromSuperview];
    }];
}

- (void)SelectButtonAction:(UIButton *)btn
{
    if (m_Block)
    {
        m_Block(btn.tag-100);
    }
    [self hide];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

@end
