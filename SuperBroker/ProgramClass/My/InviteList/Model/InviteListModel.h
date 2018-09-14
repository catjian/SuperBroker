//
//  InviteListModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteListModel : NSObject

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

- (NSArray *)getInviteListData;
+ (NSArray *)getInviteListDataWithList:(NSArray *)listArr;

@end


@interface InviteDetailModel : NSObject

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSString *brokerIdentityCard;

@property (nonatomic, strong) NSString *levelId;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *verifyCode;

@property (nonatomic, strong) NSString *payType;

@property (nonatomic, strong) NSString *platformId;

@property (nonatomic, strong) NSString *incomeAll;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *parentInviteCode;

@property (nonatomic, strong) NSString *vouchers;

@property (nonatomic, strong) NSString *accountTypeName;

@property (nonatomic, strong) NSString *brokerPictureUrl;

@property (nonatomic, strong) NSString *brokerPhone;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *salt;

@property (nonatomic, strong) NSString *gender;

@property (nonatomic, strong) NSString *vouchersAll;

@property (nonatomic, strong) NSString *memberName;

@property (nonatomic, strong) NSString *credentialsSalt;

@property (nonatomic, strong) NSString *brokerInviteCode;

@property (nonatomic, strong) NSString *memberTime;

@property (nonatomic, strong) NSString *parentBrokerId;

@property (nonatomic, strong) NSString *brokerName;

@property (nonatomic, strong) NSString *brokerType;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *income;

@property (nonatomic, strong) NSString *operationId;

@property (nonatomic, strong) NSString *password;

@end


