//
//  CommonMorePickerView.h
//  EAVisionSurveyTool
//
//  Created by jian zhang on 2017/7/21.
//  Copyright © 2017年 jian zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommonMorePickerViewSelectBlock)(NSInteger component, NSInteger row);
@interface CommonMorePickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) CommonMorePickerViewSelectBlock selectBlock;
@property (nonatomic, strong) RACSubject *racSignal;
@property (nonatomic, strong) NSArray<NSArray *> *pickerDatas;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) NSMutableArray *selectPickerDatas;

- (void)reloadComponent:(NSInteger) component SelectRow:(NSInteger) row;

@end
