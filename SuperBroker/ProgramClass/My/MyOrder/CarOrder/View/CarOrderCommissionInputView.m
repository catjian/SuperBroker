//
//  CarOrderCommissionInputView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarOrderCommissionInputView.h"

@implementation CarOrderCommissionInputView
{
    UIView *backView;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"CarOrderCommissionInputView"owner:self options:nil];
        backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        [self.inputTF setDelegate:self];
        [self.inputTF becomeFirstResponder];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.block)
    {
        self.block(nil);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.floatValue > [DIF_APPDELEGATE.mybrokeramount[@"vouchers"] floatValue])
    {
        [self makeToast:@"输入数量大于消费券余额" duration:2 position:CSToastPositionCenter];
        return NO;
    }
    if(self.block)
    {
        self.block(self.inputTF.text);
    }
    return YES;
}

@end
