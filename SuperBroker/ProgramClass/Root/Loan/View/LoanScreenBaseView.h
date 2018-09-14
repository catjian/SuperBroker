//
//  LoanScreenBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanScreenBaseViewCell.h"

typedef void(^LoanScreenBaseViewBlock)(NSArray *);

@interface LoanScreenBaseView : UIView

@property (nonatomic, copy) LoanScreenBaseViewBlock block;
@property (nonatomic, strong) NSArray *screenDataArr;
@property (nonatomic, copy) NSString *screenIdStr;
@property (nonatomic) BOOL isSingle;

@end
