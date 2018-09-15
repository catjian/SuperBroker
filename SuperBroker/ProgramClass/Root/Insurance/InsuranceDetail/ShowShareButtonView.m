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
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTapGesture:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)hideTapGesture:(UIGestureRecognizer *)reco
{
    [self hide];
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
    [DIF_APPDELEGATE shareWebPageToPlatformType:UMSocialPlatformType_Sina
                                      URLString:self.shareContent
                                          title:self.title
                                          descr:self.descr];
}

- (IBAction)wechatButtonEvent:(id)sender
{
    [DIF_APPDELEGATE shareWebPageToPlatformType:UMSocialPlatformType_WechatSession
                                      URLString:self.shareContent
                                          title:self.title
                                          descr:self.descr];
}

- (IBAction)QQButtonEvent:(id)sender {
    [DIF_APPDELEGATE shareWebPageToPlatformType:UMSocialPlatformType_QQ
                                      URLString:self.shareContent
                                          title:self.title
                                          descr:self.descr];
}

- (IBAction)cancelButtonEvent:(id)sender
{
    [self hide];
}

@end
