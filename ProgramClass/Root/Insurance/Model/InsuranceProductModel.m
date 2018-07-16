//
//  InsuranceProductModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceProductModel.h"

@implementation InsuranceProductModel

- (NSArray *)getInsuranceProductModel
{
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSMutableAttributedString *contentTitle = [[NSMutableAttributedString alloc] initWithString:@"优先综合意外险"];
    [contentTitle FontAttributeNameWithFont:DIF_DIFONTOFSIZE(18) Range:NSMakeRange(0, contentTitle.length)];
    [contentTitle ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"333333") Range:NSMakeRange(0, contentTitle.length)];
    NSMutableAttributedString *contentAge = [[NSMutableAttributedString alloc] initWithString:@"投保年龄：6个月-65周岁"];
    [contentAge FontAttributeNameWithFont:DIF_DIFONTOFSIZE(13) Range:NSMakeRange(0, contentAge.length)];
    [contentAge ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, contentAge.length)];
    NSMutableAttributedString *contentMoney1 = [[NSMutableAttributedString alloc] initWithString:@"意外伤害：10-50万"];
    [contentMoney1 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(13) Range:NSMakeRange(0, contentMoney1.length)];
    [contentMoney1 ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, contentMoney1.length)];
    NSMutableAttributedString *contentMoney2 = [[NSMutableAttributedString alloc] initWithString:@"意外医疗：1-5万"];
    [contentMoney2 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(13) Range:NSMakeRange(0, contentMoney2.length)];
    [contentMoney2 ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, contentMoney2.length)];
    NSMutableAttributedString *contentMoney3 = [[NSMutableAttributedString alloc] initWithString:@"172元起"];
    [contentMoney3 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(22) Range:NSMakeRange(0, contentMoney3.length-2)];
    [contentMoney3 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(10) Range:NSMakeRange(contentMoney3.length-2, 2)];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    [dataArr addObject:@{@"icon":@"头像",
                         @"contentTitle":contentTitle,
                         @"contentAge":contentAge,
                         @"contentMoney1":contentMoney1,
                         @"contentMoney2":contentMoney2,
                         @"contentMoney3":contentMoney3}];
    return dataArr;
}

@end
