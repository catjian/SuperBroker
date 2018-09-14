//
//  InsuranceSpeciesModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsuranceSpeciesModel : NSObject

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSArray *insuranceSpeciesList;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSString *speciesTypeName;

@property (nonatomic, strong) NSString *createTime;

@end


@interface InsuranceSpeciesDetailModel : NSObject

@property (nonatomic, strong) NSString *keyWord;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *speciesId;

@property (nonatomic, strong) NSString *sortNumber;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSString *createTime;

@end
