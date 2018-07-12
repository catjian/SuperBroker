//
//  CarInsuranceListModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInsuranceListModel : NSObject

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *speciesDesc;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSArray *insuranceCarSpeciesList;

@end

@interface CarInsuranceSpeciesModel : NSObject

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *insuredAmount;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *isDeductible;

@property (nonatomic, strong) NSArray *selectList;

@property (nonatomic, strong) NSString *speciesDesc;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *produceId;

@end
