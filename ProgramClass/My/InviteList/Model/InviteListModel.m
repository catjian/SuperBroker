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
    
    NSArray *levelNames = @[@"高级会员", @"中级会员", @"初级会员"];
    for (NSDictionary *dic in self.list)
    {
        InviteDetailModel *model = [InviteDetailModel mj_objectWithKeyValues:dic];
        NSString *level = levelNames[model.payType.integerValue-6];
        NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:level];
        [status attatchImage:[UIImage imageNamed:level]
                  imageFrame:CGRectMake(7, -2, 13, 13)
                       Range:NSMakeRange(0, status.length)];
        [dataArr addObject:@{@"icon":model.brokerPictureUrl,
                             @"name":model.brokerName?model.brokerName:@"",
                             @"time":model.createTime?model.createTime:[CommonDate getNowDateWithFormate:@"yyyy-MM-dd"],
                             @"status":status}];
    }
    return dataArr;
}

@end

@implementation InviteDetailModel

@end

