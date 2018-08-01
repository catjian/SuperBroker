//
//  CommonHttp.h
//  uavsystem
//
//  Created by jian zhang on 16/8/4.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define DIF_HTTP_NOT_HAVE_NETWORK @"网络连接失败\n请查看网络是否连接正常！"
#define DIF_HTTP_REQUEST_PARMS_NULL @"请求数据不能为空"
#define DIF_HTTP_REQUEST_URL_NULL @"网络请求异常"

#define DIF_CommonHttpAdapter [CommonHttpAdapter sharedCommonHttp]

typedef NS_ENUM(NSUInteger, ENUM_COMMONHTTP_RESPONSE_TYPE) {
    ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS, // 000000
    ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE
};

typedef void(^CommonHttpResponseBlock)(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel);
typedef void(^CommonHttpResponseFailed)(NSError *error);
typedef void(^CommonHttpResponseProgress)(NSProgress *progress);

static NSString * const BaseUrl = @"https://malixi.51vip.biz:10326/";


@interface CommonHttpAdapter : NSObject

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *refresh_token;

+ (CommonHttpAdapter *)sharedCommonHttp;

- (void)setBaseUrl;

-(BOOL) connectedToNetwork;

#pragma mark - 用户登录
- (void)httpRequestLoginWithParameters:(NSDictionary *)parms
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 获取用户详情
- (void)httpRequestBrokerinfoWithResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 我的订单
#pragma mark - 查询保险订单列表
- (void)httpRequestMyOrderInsuranceListWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 查询车险订单列表
- (void)httpRequestMyOrderCarListWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 我的提现账户
#pragma mark - 我的全部提现账户列表
- (void)httpRequestMyAllAccountListWithParameters:(NSDictionary *)parms
                                    ResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 添加我的银行卡账户
- (void)httpRequestMyAcountAddBankCardWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 修改银行卡账户
- (void)httpRequestMyAcountEditBankCardWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 添加我的支付宝账户
- (void)httpRequestMyAcountAddAlipayWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 修改支付宝账号
- (void)httpRequestMyAcountEditAlipayWithParameters:(NSDictionary *)parms
                                      ResponseBlock:(CommonHttpResponseBlock)successBlock
                                        FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 提现申请
#pragma mark - 提现申请列表
- (void)httpRequestWithDrawalListWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 我的邀请
#pragma mark - 我的邀请
- (void)httpRequestInviteListWithParameters:(NSDictionary *)parms
                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 专题
#pragma mark - 专题分类
- (void)httpRequestArticleclassifyResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 专题列表
- (void)httpRequestArticleListWithParameters:(NSDictionary *)parms
                               ResponseBlock:(CommonHttpResponseBlock)successBlock
                                 FailedBlcok:(CommonHttpResponseFailed)failedBlock;
@end
