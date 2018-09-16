//
//  IcomeListModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IncomeListModel.h"

@implementation IncomeListModel
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
    IncomePageModel *pageModel = [IncomePageModel mj_objectWithKeyValues:self.page];
    for (NSDictionary *dic in pageModel.list)
    {
        IncomePageBankModel *bankModel = [IncomePageBankModel mj_objectWithKeyValues:dic];
        NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:m_StatusDic[bankModel.status]];
        NSDictionary *colorDIc =
        @{@"申请中":@"ff5000",@"处理中":@"ff5000",@"成功":@"017aff",@"已取消":@"999999",@"失败":@"000000"};
        [status ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(colorDIc[m_StatusDic[bankModel.status]])
                                               Range:NSMakeRange(0, status.length)];
        [dataArr addObject:@{@"icon":bankModel.accountType.integerValue == 40?@"银联-86x86":@"支付宝-86x86",
                             @"name":bankModel.accountName?bankModel.accountName:@"",
                             @"time":bankModel.withdrawalTime?[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:bankModel.withdrawalTime.integerValue/1000] Formate:@"yyyy-MM-dd HH:mm"]:[CommonDate getNowDateWithFormate:@"yyyy-MM-dd HH:mm"],
//                             @"money":bankModel.withdrawalAmount?[NSString stringWithFormat:@"%.2f",bankModel.withdrawalAmount.floatValue]:@"0.00",
                             @"money":bankModel.withdrawalAmount?[NSString stringWithFormat:@"%@",bankModel.withdrawalAmount]:@"0.00",
                             @"status":status}];
    }
    return dataArr;
}

@end

@implementation IncomePageModel

@end

@implementation IncomePageBankModel

@end
