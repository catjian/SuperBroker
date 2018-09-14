//
//  CommonSheetView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonSheetViewSelectBlock)(NSInteger tag);

@interface CommonSheetView : UIView

- (void) initWithSheetTitle:(NSArray *)titles
              ResponseBlock:(CommonSheetViewSelectBlock)block;

@end
