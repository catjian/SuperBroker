//
//  InsuranceProductModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceProductModel.h"

@implementation InsuranceProductModel


@end

@implementation InsuranceProductDetailModel

- (NSDictionary *)getInsuranceProductDetailDictionary;
{
    NSMutableAttributedString *contentTitle = [[NSMutableAttributedString alloc] initWithString:self.prodName];
    [contentTitle FontAttributeNameWithFont:DIF_DIFONTOFSIZE(18) Range:NSMakeRange(0, contentTitle.length)];
    [contentTitle ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"333333") Range:NSMakeRange(0, contentTitle.length)];
    NSMutableAttributedString *contentAge = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"投保年龄：%@周岁",self.age]];
    [contentAge FontAttributeNameWithFont:DIF_DIFONTOFSIZE(13) Range:NSMakeRange(0, contentAge.length)];
    [contentAge ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, contentAge.length)];
//    NSMutableAttributedString *contentMoney1 = [[NSMutableAttributedString alloc] initWithString:self.coverage];
//    [contentMoney1 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(13) Range:NSMakeRange(0, contentMoney1.length)];
//    [contentMoney1 ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, contentMoney1.length)];
//    NSMutableAttributedString *contentMoney2 = [[NSMutableAttributedString alloc] initWithString:@"意外医疗：1-5万"];
//    [contentMoney2 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(13) Range:NSMakeRange(0, contentMoney2.length)];
//    [contentMoney2 ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"999999") Range:NSMakeRange(0, contentMoney2.length)];
    NSMutableAttributedString *contentMoney3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元起",self.premium]];
    [contentMoney3 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(19) Range:NSMakeRange(0, contentMoney3.length-2)];
    [contentMoney3 FontAttributeNameWithFont:DIF_DIFONTOFSIZE(10) Range:NSMakeRange(contentMoney3.length-2, 2)];
    return @{@"icon":self.titlePictureUrl,
             @"contentTitle":contentTitle,
             @"contentAge":contentAge,
             @"contentMoney1":self.coverage,
//             @"contentMoney2":contentMoney2,
             @"contentMoney3":contentMoney3,
             @"promotionRewards":self.promotionRewards
             };
}
@end

@implementation InsuranceOrderDetailModel

@end

