//
//  CommonADAutoView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonADAutoViewSelectBlock)(NSInteger page);

@interface CommonADAutoView : UIView

@property (nonatomic, copy) CommonADAutoViewSelectBlock selectBlock;
@property (nonatomic, strong) NSArray *picArr;

@end
