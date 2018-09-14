//
//  IcomeListModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyIncomeListModel.h"

@implementation MyIncomeListModel
{
    NSDictionary *m_StatusDic;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        m_StatusDic = @{@"68":@"申请中",@"69":@"处理中",@"70":@"成功",@"71":@"取消",@"21":@"失败"};
    }
    return self;
}

- (NSArray *)getIcomeListData
{
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dic in self.list)
    {
        MyIncomePageModel *bankModel = [MyIncomePageModel mj_objectWithKeyValues:dic];
//        NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:m_StatusDic[bankModel.status]];
//        [status ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ff5000") Range:NSMakeRange(0, status.length)];
        [dataArr addObject:@{@"icon":bankModel.productUrl,
                             @"name":bankModel.productName?bankModel.productName:@"",
                             @"time":bankModel.createDate?[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:bankModel.createDate.integerValue/1000] Formate:@"yyyy-MM-dd HH:mm"]:[CommonDate getNowDateWithFormate:@"yyyy-MM-dd HH:mm"],
//                             @"money":bankModel.insuranceMoney?[NSString stringWithFormat:@"%.2f",bankModel.insuranceMoney.floatValue]:@"0.00",
                             @"money":bankModel.insuranceMoney?[NSString stringWithFormat:@"%@",bankModel.insuranceMoney]:@"0.00",
                             @"status":bankModel.orderTypeName?bankModel.orderTypeName:@""}];
    }
    return dataArr;
}

@end

@implementation  MyIncomePageModel

@end

@implementation  MyIncomePageBankModel

@end

