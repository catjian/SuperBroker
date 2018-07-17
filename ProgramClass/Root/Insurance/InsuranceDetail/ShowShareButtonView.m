//
//  ShowShareButtonView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ShowShareButtonView.h"

@interface ShowShareButtonView()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end

@implementation ShowShareButtonView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShowShareButtonView"owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        [self.backView setAlpha:0];
        [self.buttonView setTop:frame.size.height];
    }
    return self;
}

- (void)show
{
    [UIView animateWithDuration:.5 animations:^{
        [self.backView setAlpha:1];
        [self.buttonView setTop:self.height-self.buttonView.height];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.5 animations:^{
        [self.backView setAlpha:0];
        [self.buttonView setTop:self.height];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)sinaButtonEvent:(id)sender
{
}

- (IBAction)wechatButtonEvent:(id)sender
{
}

- (IBAction)cancelButtonEvent:(id)sender
{
    [self hide];
}

@end
