//
//  CancelCommitOrderView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CancelCommitOrderView.h"

@interface CancelCommitOrderView()

@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation CancelCommitOrderView
{
    UIView *backView;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"CancelCommitOrderView"owner:self options:nil];
        backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        [self.contentView.layer setCornerRadius:5];
        [self.contentView.layer setMasksToBounds:YES];
    }
    return self;
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
        [backView setAlpha:0];
        [self.contentView setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)successButtonEvent:(id)sender
{
    if (self.block)
    {
        self.block(YES);
    }
    [self hide];
}

- (IBAction)cancelButtonEvent:(id)sender
{
    if (self.block)
    {
        self.block(NO);
    }
    [self hide];
}
@end
