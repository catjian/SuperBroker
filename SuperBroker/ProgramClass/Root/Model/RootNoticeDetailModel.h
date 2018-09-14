//
//  RootNoticeDetailModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootNoticeDetailModel : NSObject

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *noticeId;

@property (nonatomic, strong) NSString *isTop;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *noticeTitle;

@property (nonatomic, strong) NSString *noticeDetail;

@property (nonatomic, strong) NSString *noticeType;

@property (nonatomic, strong) NSString *noticeUrl;

@property (nonatomic, strong) NSString *createTime;

@end
