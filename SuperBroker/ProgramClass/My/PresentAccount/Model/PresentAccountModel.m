//
//  PresentAccountModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentAccountModel.h"

@implementation PresentAccountModel
{
    NSArray *m_AccountList;
}

- (void)setAccountList:(NSArray *)array
{
    m_AccountList = array;
}

- (NSArray *)getAccountListNormal
{
    return m_AccountList;
}

- (NSArray *)getAccountList
{
    NSMutableArray *list = [NSMutableArray array];
    BOOL isHadBank = NO, isHadAlipay = NO;
    for(NSDictionary *dic in m_AccountList)
    {
        PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:dic];
        if (model.accountType.integerValue==40 && !isHadBank)
        {
            isHadBank = YES;
            [list addObject:@{@"leftTitle":model.bankName?model.bankName:@"银行卡",
                              @"content":model.accountNo?model.accountNo:@"",
                              @"showRight":@(YES)}];
        }
        if (model.accountType.integerValue==41 && !isHadAlipay)
        {
            isHadAlipay = YES;
            [list insertObject:@{@"leftTitle":@"支付宝账户",@"content":model.accountNo?model.accountNo:@"",@"showRight":@(NO)}
                       atIndex:0];
        }
    }
    if (list.count == 0)
    {
        [list addObject:@{@"leftTitle":@"支付宝账户",@"content":@"",@"showRight":@(NO)}];
        [list addObject:@{@"leftTitle":@"银行卡",@"content":@"",@"showRight":@(YES)}];
    }
    else if (list.count == 1)
    {
        if(![list.firstObject[@"leftTitle"] isEqualToString:@"支付宝账户"])
        {
            [list insertObject:@{@"leftTitle":@"支付宝账户",@"content":@"",@"showRight":@(NO)}
                       atIndex:0];
        }
        else
        {
            [list addObject:@{@"leftTitle":@"银行卡",@"content":@"",@"showRight":@(YES)}];            
        }
    }
    
    return list;
}

@end

@implementation PresentDrawalRuleModel

@end
