//
//  IcomeListModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IncomeListModel.h"

@implementation IncomeListModel

- (NSArray *)getIcomeListData
{
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:@"待审核"];
    [status ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ff5000") Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"银联-86x86",
                         @"name":@"招商银行（5419）",
                         @"time":@"2018-07-10 14:20",
                         @"money":@"98.00",
                         @"status":status}];
    status = [[NSMutableAttributedString alloc] initWithString:@"成功"];
    [status ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"017aff") Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"支付宝-86x86",
                         @"name":@"支付宝账户",
                         @"time":@"2018-07-10 14:20",
                         @"money":@"98.00",
                         @"status":status}];
    status = [[NSMutableAttributedString alloc] initWithString:@"失败"];
    [status ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"银联-86x86",
                         @"name":@"招商银行（5419）",
                         @"time":@"2018-07-10 14:20",
                         @"money":@"98.00",
                         @"status":status}];
    status = [[NSMutableAttributedString alloc] initWithString:@"待发放"];
    [status ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"66cc66") Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"银联-86x86",
                         @"name":@"招商银行（5419）",
                         @"time":@"2018-07-10 14:20",
                         @"money":@"98.00",
                         @"status":status}];
    return dataArr;
}

@end
