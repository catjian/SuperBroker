//
//  InviteListModel.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InviteListModel.h"

@implementation InviteListModel

- (NSArray *)getInviteListData
{
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:@"高级会员"];
    [status attatchImage:[UIImage imageNamed:@"高级会员"]
              imageFrame:CGRectMake(7, -2, 13, 13)
                   Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"银联-86x86",
                         @"name":@"招商银行",
                         @"time":@"2018-07-10 14:20",
                         @"status":status}];
    status = [[NSMutableAttributedString alloc] initWithString:@"高级会员"];
    [status attatchImage:[UIImage imageNamed:@"高级会员"]
              imageFrame:CGRectMake(7, -2, 13, 13)
                   Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"支付宝-86x86",
                         @"name":@"支付宝账户",
                         @"time":@"2018-07-10 14:20",
                         @"status":status}];
    status = [[NSMutableAttributedString alloc] initWithString:@"初级会员"];
    [status attatchImage:[UIImage imageNamed:@"初级会员"]
              imageFrame:CGRectMake(7, -2, 13, 13)
                   Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"银联-86x86",
                         @"name":@"招商银行",
                         @"time":@"2018-07-10 14:20",
                         @"status":status}];
    status = [[NSMutableAttributedString alloc] initWithString:@"初级会员"];
    [status attatchImage:[UIImage imageNamed:@"初级会员"]
              imageFrame:CGRectMake(7, -2, 13, 13)
                   Range:NSMakeRange(0, status.length)];
    [dataArr addObject:@{@"icon":@"银联-86x86",
                         @"name":@"招商银行",
                         @"time":@"2018-07-10 14:20",
                         @"status":status}];
    return dataArr;
}

@end
