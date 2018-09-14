//
//  MessageNoticeListModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageNoticeListModel : NSObject

@property (nonatomic, strong) NSString *startRow;

@property (nonatomic, strong) NSString *pageSize;

@property (nonatomic, strong) NSString *navigateLastPage;

@property (nonatomic, strong) NSString *pages;

@property (nonatomic, strong) NSString *total;

@property (nonatomic, strong) NSString *navigateFirstPage;

@property (nonatomic, strong) NSString *endRow;

@property (nonatomic, strong) NSString *hasPreviousPage;

@property (nonatomic, strong) NSString *firstPage;

@property (nonatomic, strong) NSString *isFirstPage;

@property (nonatomic, strong) NSString *lastPage;

@property (nonatomic, strong) NSString *prePage;

@property (nonatomic, strong) NSString *size;

@property (nonatomic, strong) NSString *navigatePages;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSString *isLastPage;

@property (nonatomic, strong) NSString *pageNum;

@property (nonatomic, strong) NSString *nextPage;

@property (nonatomic, strong) NSString *hasNextPage;

@property (nonatomic, strong) NSArray *navigatepageNums;

@end

@interface MessageNoticeDetailModel : NSObject

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *brokerId;

@property (nonatomic, strong) NSString *noticeId;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *noticeTitle;

@property (nonatomic, strong) NSString *noticeDetail;

@property (nonatomic, strong) NSString *noticeType;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic) BOOL isRead;

@end
