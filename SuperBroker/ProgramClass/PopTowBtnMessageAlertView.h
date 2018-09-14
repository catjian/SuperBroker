//
//  PopTowBtnMessageAlertView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopTowBtnMessageAlertViewBlock)(NSInteger index);

@interface PopTowBtnMessageAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title
                      Message:(NSString *)message
                   LeftButton:(NSString *)leftBtn
                  RightButton:(NSString *)rightBtn
                        Block:(PopTowBtnMessageAlertViewBlock)block;

- (void)show;



@end
