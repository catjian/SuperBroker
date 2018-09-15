//
//  ShowShareButtonView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowShareButtonView : UIView

@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descr;

- (void)show;

@end
