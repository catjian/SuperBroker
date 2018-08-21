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

@interface CarInsuranceUploadParamsModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *insuredName;
@property (nonatomic, strong) NSString *insuredPhone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *carOwnerName;
@property (nonatomic, strong) NSString *carOwnerCertificate;
@property (nonatomic, strong) NSString *carOwnerCertificateUrl;
@property (nonatomic, strong) NSString *carArea;
@property (nonatomic, strong) NSString *carNumber;
@property (nonatomic, strong) NSString *carIdentificationCode;
@property (nonatomic, strong) NSString *carEngineCode;
@property (nonatomic, strong) NSString *carRegisterTime;
@property (nonatomic, strong) NSString *carOilType;
@property (nonatomic, strong) NSString *carDrivingLicenseUrl;
@property (nonatomic, strong) NSString *species;

@end

@interface CarsPeciesDataDetailModel : NSObject

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *speciesDesc;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSArray *insuranceCarSpeciesList;

@end

@interface CarSpeciesDataListDetailModel : NSObject

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *isInsured;

@property (nonatomic, strong) NSString *speciesDesc;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSArray *selectList;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *isDeductible;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSString *insuredAmount;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *produceId;

@property (nonatomic, strong) NSString *selectMoney;

@end

@interface CarInsuranceCustomerDetail : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *cityNum;
@property (nonatomic, strong) NSString *plateNum;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *VINStr;
@property (nonatomic, strong) NSString *engineNum;
@property (nonatomic, strong) NSString *registerDate;
@property (nonatomic, strong) NSString *oilType;
@property (nonatomic, strong) NSString *carOwner;
@property (nonatomic, strong) NSString *ownerCardId;
@property (nonatomic, strong) NSString *userIDCardPic;
@property (nonatomic, strong) NSString *driverCardPic;

@end

