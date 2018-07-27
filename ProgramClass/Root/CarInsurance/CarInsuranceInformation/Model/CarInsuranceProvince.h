//
//  CarInsuranceProvince.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInsuranceProvince : NSObject

+ (NSArray *)getProvinceArray;

+ (NSArray *)getCityArrWithProvince:(NSString *)province;

@end
