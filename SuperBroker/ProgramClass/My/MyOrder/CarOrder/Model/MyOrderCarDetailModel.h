//
//  MyOrderCarDetailModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderCarDetailModel : NSObject

@property (nonatomic, strong) NSArray *orderLogs;

@property (nonatomic, strong) NSString *searchEndTime;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *isShare;

@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, strong) NSString *prodId;

@property (nonatomic, strong) NSString *productUrl;

@property (nonatomic, strong) NSArray *includeOrderStatus;

@property (nonatomic, strong) NSString *brokerName;

@property (nonatomic, strong) NSString *preCommissionAmount;

@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic, strong) NSString *insuredId;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *generalizeAmount;

@property (nonatomic, strong) NSString *promotionRewards;

@property (nonatomic, strong) NSString *orderTypeName;

@property (nonatomic, strong) NSString *searchStartTime;

@property (nonatomic, strong) NSArray *includeOrderType;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSDictionary *carInsuredInfo;

@property (nonatomic, strong) NSString *orderCode;

@property (nonatomic, strong) NSString *orderAmount;

@property (nonatomic, strong) NSString *orderCodeStr;

@property (nonatomic, strong) NSString *ensureId;

@property (nonatomic, strong) NSString *operationId;

@property (nonatomic, strong) NSString *orderStatusName;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *insuredInfo;

@property (nonatomic, strong) NSDictionary *managerInfo;

@property (nonatomic, strong) NSString *commissionAmount;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSArray *carOrderSpecies;

@property (nonatomic, strong) NSString *statusReason;

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSArray *excludeOrderStatus;

@property (nonatomic, strong) NSString *platformId;

@end

@interface MyOrderCarInsuredInfoModel : NSObject

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *insuredName;

@property (nonatomic, strong) NSString *insuredPhone;

@property (nonatomic, strong) NSString *productId;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *carArea;

@property (nonatomic, strong) NSString *carDrivingLicenseUrl;

@property (nonatomic, strong) NSString *insuredId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *carEngineCode;

@property (nonatomic, strong) NSString *carIdentificationCode;

@property (nonatomic, strong) NSString *carOilType;

@property (nonatomic, strong) NSString *carOwnerCertificate;

@property (nonatomic, strong) NSString *carOwnerCertificateUrl;

@property (nonatomic, strong) NSString *carOwnerName;

@property (nonatomic, strong) NSString *carRegisterTime;

@property (nonatomic, strong) NSString *carNumber;

@end

@interface MyOrderCarOrderSpeciesModel : NSObject

@property (nonatomic, strong) NSString *insuredAmount;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *isDeductible;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSString *insuredId;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *speciesTypeId;

@property (nonatomic, strong) NSString *speciesTypeName;

@property (nonatomic, strong) NSString *createTime;

@end

@interface MyOrderCarManagerInfoModel : NSObject

@property (nonatomic, strong) NSString *keyWord;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *managerId;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *weixin;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *qrCodeUrl;

@property (nonatomic, strong) NSString *department;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *managerName;

@end

@interface MyOrderCarOrderLogsModel : NSObject

@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *orderStatusName;

@property (nonatomic, strong) NSString *statusTimeName;

@end
