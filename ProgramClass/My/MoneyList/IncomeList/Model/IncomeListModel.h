//
//  IcomeListModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IncomeListModel : NSObject

@property (nonatomic, strong) NSString *income;

@property (nonatomic, strong) NSString *incomeAll;

@property (nonatomic, strong) NSDictionary *page;

- (NSArray *)getIcomeListData;

@end

@interface IncomePageModel :NSObject

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


@interface IncomePageBankModel :NSObject

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *withdrawalId;

@property (nonatomic, strong) NSString *payId;

@property (nonatomic, strong) NSString *withdrawalAccount;

@property (nonatomic, strong) NSString *lastOperatorName;

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSString *accountType;

@property (nonatomic, strong) NSString *lastOperator;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *accountName;

@property (nonatomic, strong) NSString *withdrawalAmount;

@property (nonatomic, strong) NSString *withdrawalStatus;

@property (nonatomic, strong) NSString *withdrawalTime;

@property (nonatomic, strong) NSArray *insuranceWithdrawalDetailList;

@property (nonatomic, strong) NSString *brokerName;

@property (nonatomic, strong) NSString *status;

@end
