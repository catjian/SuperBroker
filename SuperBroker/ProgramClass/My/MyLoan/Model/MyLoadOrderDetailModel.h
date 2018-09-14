//
//  MyLoadOrderDetailModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/5.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLoadOrderDetailModel : NSObject

@property (nonatomic, strong) NSDictionary *insuranceOrder;

@property (nonatomic, strong) NSDictionary *insuranceLoanBorrower;

@property (nonatomic, strong) NSDictionary *insuranceLoanProduct;

@end


@interface MyLoadInsuranceOrderModel : NSObject

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

@property (nonatomic, strong) NSString *payChannel;

@property (nonatomic, strong) NSString *payChannelName;

@property (nonatomic, strong) NSArray *includeOrderType;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *carInsuredInfo;

@property (nonatomic, strong) NSString *orderCode;

@property (nonatomic, strong) NSString *orderAmount;

@property (nonatomic, strong) NSString *orderCodeStr;

@property (nonatomic, strong) NSString *ensureId;

@property (nonatomic, strong) NSString *operationId;

@property (nonatomic, strong) NSString *orderStatusName;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *insuredInfo;

@property (nonatomic, strong) NSString *managerInfo;

@property (nonatomic, strong) NSString *commissionAmount;

@property (nonatomic, strong) NSString *borrowerName;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSArray *carOrderSpecies;

@property (nonatomic, strong) NSString *statusReason;

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSArray *excludeOrderStatus;

@property (nonatomic, strong) NSString *platformId;

@property (nonatomic, strong) NSString *expectAmount;

@end


@interface MyLoadInsuranceLoanBorrowerModel : NSObject

@property (nonatomic, strong) NSString *loanTypeName;

@property (nonatomic, strong) NSString *loanType;

@property (nonatomic, strong) NSString *borrowerPhone;

@property (nonatomic, strong) NSString *identityCard;

@property (nonatomic, strong) NSString *createBrokerId;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *borrowerName;

@property (nonatomic, strong) NSString *loanProductId;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *expectAmount;

@property (nonatomic, strong) NSString *borrowerCertificateUrl;

@property (nonatomic, strong) NSString *borrowerId;

@property (nonatomic, strong) NSString *updateTime;

@end


@interface MyLoadInsuranceLoanProductModel : NSObject

@property (nonatomic, strong) NSString *loanCycle;

@property (nonatomic, strong) NSArray *speciesIdList;

@property (nonatomic, strong) NSString *pageSize;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *dealLimitMin;

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) NSString *detailsUrl;

@property (nonatomic, strong) NSString *dealLimit;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *loanLimit;

@property (nonatomic, strong) NSString *generalizeAmount;

@property (nonatomic, strong) NSString *loanLimitMax;

@property (nonatomic, strong) NSString *shareUrl;

@property (nonatomic, strong) NSString *loanCredit;

@property (nonatomic, strong) NSString *productId;

@property (nonatomic, strong) NSString *detailUrl;

@property (nonatomic, strong) NSString *details;

@property (nonatomic, strong) NSString *delTag;

@property (nonatomic, strong) NSString *productUrl;

@property (nonatomic, strong) NSString *loanCreditMin;

@property (nonatomic, strong) NSString *loanLimitMin;

@property (nonatomic, strong) NSString *topTag;

@property (nonatomic, strong) NSString *pageNum;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *dealLimitMax;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *speciesId;

@property (nonatomic, strong) NSString *loanCreditMax;

@end
