//
//  MyViewDataModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrokerInfoDataModel.h"

@interface MyViewDataModel : NSObject

+ (NSArray <NSArray *> *)getDataModelWithBrokerInfoDataModel:(BrokerInfoDataModel *)dataModel;

@end
