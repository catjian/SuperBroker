//
//  InsuranceProductModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsuranceProductModel : NSObject

@property (nonatomic, strong) NSString *startRow;

@property (nonatomic, strong) NSString *pageSize;

@property (nonatomic, strong) NSString *navigateLastPage;

@property (nonatomic, strong) NSString *pages;

@property (nonatomic, strong) NSString *total;

@property (nonatomic, strong) NSString *navigateFirstPage;

@property (nonatomic, strong) NSString *endRow;

@property (nonatomic, strong) NSString *hasPreviousPage;

@property (nonatomic, strong) NSString *firstPage;

@property (nonatomic, strong) NSString *isFirstPage;

@property (nonatomic, strong) NSString *lastPage;

@property (nonatomic, strong) NSString *prePage;

@property (nonatomic, strong) NSString *size;

@property (nonatomic, strong) NSString *navigatePages;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSString *isLastPage;

@property (nonatomic, strong) NSString *pageNum;

@property (nonatomic, strong) NSString *nextPage;

@property (nonatomic, strong) NSString *hasNextPage;

@property (nonatomic, strong) NSArray *navigatepageNums;

@end


@interface InsuranceProductDetailModel : NSObject

@property (nonatomic, strong) NSString *prodId;

@property (nonatomic, strong) NSArray *compIdList;

@property (nonatomic, strong) NSString *compName;

@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) NSString *speciesId;

@property (nonatomic, strong) NSString *consumptionType;

@property (nonatomic, strong) NSString *managerId;

@property (nonatomic, strong) NSString *titlePictureUrl;

@property (nonatomic, strong) NSArray *speciesIdList;

@property (nonatomic, strong) NSString *rewardMax;

@property (nonatomic, strong) NSString *maxAge;

@property (nonatomic, strong) NSString *details;

@property (nonatomic, strong) NSString *promotionRewards;

@property (nonatomic, strong) NSString *period;

@property (nonatomic, strong) NSString *rewardMin;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *prodName;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *compId;

@property (nonatomic, strong) NSString *claimsService;

@property (nonatomic, strong) NSString *instructions;

@property (nonatomic, strong) NSString *pageSize;

@property (nonatomic, strong) NSString *premium;

@property (nonatomic, strong) NSString *coverage;

@property (nonatomic, strong) NSString *pageNum;

@property (nonatomic, strong) NSString *isTop;

@property (nonatomic, strong) NSString *minAge;

@property (nonatomic, strong) NSString *speciesName;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *age;

@property (nonatomic, strong) NSString *managerName;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *terms;


@property (nonatomic, strong) NSString *shareDomain;
@property (nonatomic, strong) NSString *brokerId;
@property (nonatomic, strong) NSString *detailsUrl;
@property (nonatomic, strong) NSString *shareUrl;

- (NSDictionary *)getInsuranceProductDetailDictionary;

@end

@interface InsuranceOrderDetailModel : NSObject

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *orderStatusName;

@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSArray *orderLogs;

@property (nonatomic, strong) NSString *orderTypeName;

@property (nonatomic, strong) NSString *platformId;

@property (nonatomic, strong) NSString *generalizeAmount;

@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, strong) NSArray *carOrderSpecies;

@property (nonatomic, strong) NSArray *includeOrderType;

@property (nonatomic, strong) NSArray *excludeOrderStatus;

@property (nonatomic, strong) NSString *prodId;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *statusReason;

@property (nonatomic, strong) NSString *productUrl;

@property (nonatomic, strong) NSString *ensureId;

@property (nonatomic, strong) NSString *insuredId;

@property (nonatomic, strong) NSString *promotionRewards;

@property (nonatomic, strong) NSString *brokerName;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSArray *includeOrderStatus;

@property (nonatomic, strong) NSString *isShare;

@property (nonatomic, strong) NSString *operationId;

@property (nonatomic, strong) NSString *orderAmount;

@end
