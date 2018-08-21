//
//  IMInpuerView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IMInpuerView.h"

@implementation IMInpuerView
{
    PlaceTextView *m_TextView;
    UIView *m_InputBackView;
    UIButton *m_SendBtn;
    id m_ShowNotification;
    id m_HideNotification;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = 43;
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self createInputView];
        
        m_SendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_SendBtn setFrame:CGRectMake(0, 0, 69, 34)];
        [m_SendBtn setRight:self.width-7];
        [m_SendBtn setBottom:43-5];
        [m_SendBtn setBackgroundColor:DIF_HEXCOLOR(@"006CFF")];
        [m_SendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [m_SendBtn setTitleColor:DIF_HEXCOLOR(@"ffffff") forState:UIControlStateNormal];
        [m_SendBtn.titleLabel setFont:DIF_UIFONTOFSIZE(15)];
        [m_SendBtn addTarget:self action:@selector(IMInputViewSendButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_SendBtn];
        DIF_WeakSelf(self)
        m_ShowNotification = [[NSNotificationCenter defaultCenter]
                              addObserverForName:UIKeyboardDidShowNotification
                              object:nil
                              queue:[NSOperationQueue mainQueue]
                              usingBlock:^(NSNotification * _Nonnull note) {
                                  DIF_StrongSelf
                                  if (strongSelf.editBlock)
                                  {
                                      strongSelf.editBlock(YES,note);
                                  }
                              }];
        m_HideNotification = [[NSNotificationCenter defaultCenter]
                           addObserverForName:UIKeyboardWillShowNotification
                           object:nil
                           queue:[NSOperationQueue mainQueue]
                           usingBlock:^(NSNotification * _Nonnull note) {
                               DIF_StrongSelf
                               if (strongSelf.editBlock)
                               {
                                   strongSelf.editBlock(NO,note);
                               }
                           }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:m_ShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:m_HideNotification];
}

- (void)createInputView
{
    m_InputBackView = [[UIView alloc] initWithFrame:CGRectMake(7, 0, DIF_SCREEN_WIDTH-7*3-69, 34)];
    [m_InputBackView setCenterY:self.height/2];
    [m_InputBackView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [m_InputBackView.layer setCornerRadius:5];
    [self addSubview:m_InputBackView];
    
    m_TextView = [[PlaceTextView alloc] initWithFrame:CGRectMake(9, 0, m_InputBackView.width-18, 34)];
    [m_TextView setPlaceholder:@"输入您想说的话"];
    [m_TextView setPlaceColor:DIF_HEXCOLOR(@"999999")];
    [m_TextView setFont:DIF_UIFONTOFSIZE(15)];
    [m_TextView setRealTextColor:DIF_HEXCOLOR(@"333333")];
    [m_InputBackView addSubview:m_TextView];
    
    DIF_WeakSelf(self)
    [m_TextView setChangeBlock:^(UITextView *textView, NSRange range, NSString *replacementText) {
        DIF_StrongSelf
        NSString *contentStr;
        if (replacementText == nil || replacementText.length == 0)
        {
            contentStr = textView.text.length > 0 ?[textView.text substringToIndex:(textView.text.length-1 > 0?textView.text.length-1:0)]:@"";
        }
        else
        {
            contentStr = [textView.text stringByAppendingString:replacementText];
        }
        CGRect attrsRect = [contentStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(15)}
                                               context:nil];
        CGFloat maxWidht = textView.width;
        int lineNum = ceil(attrsRect.size.width / maxWidht);
        lineNum = lineNum >= 3? 3:lineNum;
        if (lineNum > 1)
        {
            [strongSelf->m_InputBackView setHeight:(attrsRect.size.height*lineNum+14>34?attrsRect.size.height*lineNum+14:34)];
            [strongSelf setHeight:strongSelf->m_InputBackView.height+9];
            [strongSelf->m_TextView setHeight:attrsRect.size.height*lineNum];
        }
        else
        {
            [strongSelf setHeight:43];
            [strongSelf->m_InputBackView setHeight:34];
            [strongSelf->m_TextView setHeight:34];
        }
        
        [strongSelf->m_SendBtn setBottom:strongSelf.height-5];
        if (strongSelf.changeBlock)
        {
            strongSelf.changeBlock();
        }
    }];
}

- (void)IMInputViewSendButtonEvent:(UIButton *)btn
{
    if (self.sendBlock && m_TextView.text.length > 0 && ![m_TextView.text isEqualToString:@"输入您想说的话"])
    {
        self.sendBlock(m_TextView.text);
        m_TextView.text = nil;
    }
}

@end
