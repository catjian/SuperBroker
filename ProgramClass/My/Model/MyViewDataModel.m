//
//  MyViewDataModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyViewDataModel.h"

@implementation MyViewDataModel

+ (NSArray <NSArray *> *)getDataModelWithBrokerInfoDataModel:(BrokerInfoDataModel *)dataModel
{
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr addObject:@[@{@"icon":@"我的订单",@"content":@"我的订单"}]];
    [dataArr addObject:@[@{@"icon":@"基本信息",@"content":@"基本信息"},
                           @{@"icon":@"提现账户",@"content":@"提现账户"},
                           @{@"icon":@"我的提现",@"content":@"我的提现"},
                           @{@"icon":@"我的邀请",@"content":@"我的邀请"}]];
    [dataArr addObject:@[@{@"icon":@"设置",@"content":@"设置"}]];
    NSString *InviteCodeCode = ((dataModel&&dataModel.brokerInviteCode)?dataModel.brokerInviteCode:@"");
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:InviteCodeCode];
    [attstring FontAttributeNameWithFont:DIF_DIFONTOFSIZE(18) Range:NSMakeRange(0, attstring.length)];
    [dataArr addObject:@[@{@"title":@"邀请码:", @"content":attstring}]];
    return dataArr;
}

@end
