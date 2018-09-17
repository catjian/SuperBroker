//
//  PaymentListModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PaymentListModel.h"

@implementation PaymentListModel

- (NSArray *)getPaymentListData
{
//    NSMutableArray *dataArr = [NSMutableArray array];
//
//    NSMutableAttributedString *money = [[NSMutableAttributedString alloc] initWithString:@"+50.00"];
//    [money ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ff5000") Range:NSMakeRange(0, money.length)];
//    [dataArr addObject:@{@"name":@"招商银行（5419）",
//                         @"time":@"2018-07-10 14:20",
//                         @"money":money}];
//    money = [[NSMutableAttributedString alloc] initWithString:@"+29.00"];
//    [money ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ff5000") Range:NSMakeRange(0, money.length)];
//    [dataArr addObject:@{@"name":@"支付宝账户",
//                         @"time":@"2018-07-10 14:20",
//                         @"money":money}];
//    money = [[NSMutableAttributedString alloc] initWithString:@"-50.00"];
//    [money ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"333333") Range:NSMakeRange(0, money.length)];
//    [dataArr addObject:@{@"name":@"招商银行（5419）",
//                         @"time":@"2018-07-10 14:20",
//                         @"money":money}];
//    money = [[NSMutableAttributedString alloc] initWithString:@"-29.00"];
//    [money ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"333333") Range:NSMakeRange(0, money.length)];
//    [dataArr addObject:@{@"name":@"招商银行（5419）",
//                         @"time":@"2018-07-10 14:20",
//                         @"money":money}];
//    return dataArr;
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dic in self.list)
    {
        PaymentListDetailModel *pageModel = [PaymentListDetailModel mj_objectWithKeyValues:dic];
        NSMutableAttributedString *money = [[NSMutableAttributedString alloc] initWithString:
                                            [NSString stringWithFormat:@"%@",pageModel.amount]];
        [money ForegroundColorAttributeNamWithColor:[pageModel.directionName isEqualToString:@"收入"]? DIF_HEXCOLOR(@"ff5000"):DIF_HEXCOLOR(@"333333")
                                              Range:NSMakeRange(0, money.length)];
        [dataArr addObject:@{@"name":pageModel.orderTypeName,
                             @"time":[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:pageModel.createTime.integerValue/1000] Formate:@"yyyy-MM-dd HH:mm"],
//                             @"time":pageModel.createDate?pageModel.createDate:@"",
                             @"money":money}];

    }
    return dataArr;
}

@end


@implementation PaymentListDetailModel

@end

