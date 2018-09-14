//
//  IMInpuerView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IMInpuerViewSizeChangeBlock)(void);
typedef void(^IMInpuerViewSendEventBlock)(NSString * message);
typedef void(^IMInpuerViewEditBlock)(BOOL, NSNotification*);

@interface IMInpuerView : UIView

@property (nonatomic, copy) IMInpuerViewSizeChangeBlock changeBlock;
@property (nonatomic, copy) IMInpuerViewSendEventBlock sendBlock;
@property (nonatomic, copy) IMInpuerViewEditBlock editBlock;

@end
