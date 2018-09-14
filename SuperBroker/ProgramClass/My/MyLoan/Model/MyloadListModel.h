//
//  MyloadListModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/5.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyloadListModel : NSObject

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

@interface MyloadListDetailModel : NSObject

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
