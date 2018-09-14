//
//  ScreenDataModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/3.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenDataModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSArray *list;

@end

@interface ScreenDetailDataModel : NSObject

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *dictId;

@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSString *dictName;

@property (nonatomic, strong) NSString *dictType;

@property (nonatomic, strong) NSString *dictCode;

@end
