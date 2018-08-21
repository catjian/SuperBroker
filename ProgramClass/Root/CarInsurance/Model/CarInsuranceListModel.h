//
//  CarInsuranceListModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInsuranceListModel : NSObject

@property (nonatomic, strong) NSString *productId;

@property (nonatomic, strong) NSString *productUrl;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSString *generalizeAmount;

@property (nonatomic, strong) NSString *managerId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *managerName;

@property (nonatomic, strong) NSString *sortNumber;

@property (nonatomic, strong) NSString *companyId;

@property (nonatomic, strong) NSString *status;

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
