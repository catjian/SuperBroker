//
//  CarOrderCommissionInputView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarOrderCommissionInputViewBlock)(NSString *money);

@interface CarOrderCommissionInputView : UIView <UITextFieldDelegate>

@property (copy, nonatomic) CarOrderCommissionInputViewBlock block;
@property (weak, nonatomic) IBOutlet UILabel *carOrderMoneyLab;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UILabel *allCommissionLab;


@end
