//
//  CancelCommitOrderView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelCommitOrderViewBlock)(BOOL isSuccess);

@interface CancelCommitOrderView : UIView

@property (nonatomic, copy) CancelCommitOrderViewBlock block;

- (void)show;

@end
