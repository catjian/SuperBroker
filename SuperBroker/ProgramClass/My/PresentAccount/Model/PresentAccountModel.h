//
//  PresentAccountModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentAccountModel : NSObject

@property (nonatomic, strong) NSString *bankName;

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSString *accountNo;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *withdrawalAccountId;

@property (nonatomic, strong) NSString *accountType;

@property (nonatomic, strong) NSString *createTime;

- (void)setAccountList:(NSArray *)array;
- (NSArray *)getAccountList;
- (NSArray *)getAccountListNormal;

@end


@interface PresentDrawalRuleModel : NSObject

@property (nonatomic, strong) NSString *income;

@property (nonatomic, strong) NSString *incomeAll;

@property (nonatomic, strong) NSString *minWithdrawalAmount;

@property (nonatomic, strong) NSString *maxWithdrawalAmount;

@property (nonatomic, strong) NSString *withdrawalDescription;

@end
