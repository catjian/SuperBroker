//
//  ArticleclassifyModel.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/13.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleclassifyModel : NSObject

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *siteId;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *classifyType;

@property (nonatomic, strong) NSString *parentClassifyId;

@property (nonatomic, strong) NSString *comment;

@property (nonatomic, strong) NSString *classifyName;

@property (nonatomic, strong) NSString *classifyIds;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *delTag;

@property (nonatomic, strong) NSString *sortNumber;

@property (nonatomic, strong) NSString *classifyId;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *updateTime;

@end


@interface ArticleListModel : NSObject

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

@interface ArticleListDetailModel : NSObject

@property (nonatomic, strong) NSString *insuranceName;

@property (nonatomic, strong) NSString *classifyId;

@property (nonatomic, strong) NSString *siteId;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) NSString *articleStatus;

@property (nonatomic, strong) NSArray *imgUrlList;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *hits;

@property (nonatomic, strong) NSString *coverNumber;

@property (nonatomic, strong) NSString *createTimeEnd;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *articleIds;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *isTop;

@property (nonatomic, strong) NSString *classifyName;

@property (nonatomic, strong) NSString *delTag;

@property (nonatomic, strong) NSString *articleId;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *comment;

@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *createTimeStart;

@property (nonatomic, strong) NSString *detailsUrl;

@end

@interface ArticleDetailModel : NSObject

@property (nonatomic, strong) NSString *insuranceName;

@property (nonatomic, strong) NSString *classifyId;

@property (nonatomic, strong) NSString *siteId;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) NSString *articleStatus;

@property (nonatomic, strong) NSArray *imgUrlList;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *hits;

@property (nonatomic, strong) NSString *coverNumber;

@property (nonatomic, strong) NSString *createTimeEnd;

@property (nonatomic, strong) NSString *updateTime;

@property (nonatomic, strong) NSString *articleIds;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) NSString *isTop;

@property (nonatomic, strong) NSString *classifyName;

@property (nonatomic, strong) NSString *delTag;

@property (nonatomic, strong) NSString *articleId;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *comment;

@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *createTimeStart;

@property (nonatomic, strong) NSString *shareDomain;

@property (nonatomic, strong) NSString *detailsUrl;

@end
