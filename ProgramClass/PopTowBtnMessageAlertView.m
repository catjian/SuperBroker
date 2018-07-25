//
//  PopTowBtnMessageAlertView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PopTowBtnMessageAlertView.h"

@interface PopTowBtnMessageAlertView()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;


@end

@implementation PopTowBtnMessageAlertView
{
    PopTowBtnMessageAlertViewBlock m_Block;
    UIView *backView;
}


- (instancetype)initWithTitle:(NSString *)title
                      Message:(NSString *)message
                   LeftButton:(NSString *)leftBtn
                  RightButton:(NSString *)rightBtn
                        Block:(PopTowBtnMessageAlertViewBlock)block
{
    self = [self initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT)];
    [DIF_APPDELEGATE.window addSubview:self];
    if (self)
    {
        m_Block = block;
        [self.titleLab setText:title];
        [self.messageLab setText:message];
        [self.messageLab setLineBreakMode:0];
        [self.messageLab setLineBreakMode:NSLineBreakByCharWrapping];
        UIImage *image = [UIImage imageNamed:leftBtn];
        if (image)
        {
            [self.leftBtn setImage:image forState:UIControlStateNormal];
        }
        else
        {
            [self.leftBtn setTitle:leftBtn forState:UIControlStateNormal];
        }
        image = [UIImage imageNamed:rightBtn];
        if (image)
        {
            [self.rightBtn setImage:image forState:UIControlStateNormal];
        }
        else
        {
            [self.rightBtn setTitle:leftBtn forState:UIControlStateNormal];
        }
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"PopTowBtnMessageAlertView" owner:self options:nil];
        backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
    }
    return self;
}

- (IBAction)leftButtonEvent:(id)sender
{
    if (m_Block)
    {
        m_Block(0);
    }
    [self hide];
}

- (IBAction)rightButtonEvent:(id)sender
{
    if (m_Block)
    {
        m_Block(1);
    }
    [self hide];
}

- (void)show
{
    [UIView animateWithDuration:.5 animations:^{
        [backView setAlpha:1];
        [self.contentView setAlpha:1];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.5 animations:^{
        [self setAlpha:0];
        [self.contentView setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
