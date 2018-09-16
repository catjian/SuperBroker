//
//  LoadCommitOrderModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadCommitOrderModel : NSObject

@property (nonatomic, strong) NSString *borrowerName;

@property (nonatomic, strong) NSString *expectAmount;

@property (nonatomic, strong) NSString *generalizeAmount;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *orderTypeName;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSString *productUrl;

@property (nonatomic, strong) NSString *orderStatusName;

@end
