//
//  PresentAccountModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentAccountModel.h"

@implementation PresentAccountModel

- (NSArray *)getAccountList
{
    NSMutableArray *list = [NSMutableArray array];
    [list addObject:@{@"leftTitle":@"支付宝账户",@"content":@"",@"showRight":@(NO)}];
    [list addObject:@{@"leftTitle":@"银行卡",@"content":@"",@"showRight":@(YES)}];
    
    
    return list;
}

@end
