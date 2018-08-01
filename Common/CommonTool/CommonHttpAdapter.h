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

#pragma mark - 个人中心
#pragma mark - 获取用户详情
- (void)httpRequestBrokerinfoWithResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 修改个人信息
- (void)httpRequestModifyBrokerinfoWithParameters:(NSDictionary *)parms
                                    ResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 修改手机号码
- (void)httpRequestBrokerinfoPhoneWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
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
#pragma mark - 专题详情/常见问题详情
- (void)httpRequestArticleDetailWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 首页
#pragma mark - 通知公告列表
- (void)httpRequestIndexnNoticeResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 公告详情
- (void)httpRequestNoticeDetailWithParameters:(NSDictionary *)parms
                                ResponseBlock:(CommonHttpResponseBlock)successBlock
                                  FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 轮播图列表
- (void)httpRequestMovePictureResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 注册时获取验证码
- (void)httpRequestRegistrySmsCodeWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 注册提交
- (void)httpRequestRegistryWithParameters:(NSDictionary *)parms
                            ResponseBlock:(CommonHttpResponseBlock)successBlock
                              FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 登录时获取验证码
- (void)httpRequestSmsLoginSmsCodeWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 短信验证码登录
- (void)httpRequestSmsLoginWithParameters:(NSDictionary *)parms
                            ResponseBlock:(CommonHttpResponseBlock)successBlock
                              FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 通过密码登录
- (void)httpRequestLoginWithParameters:(NSDictionary *)parms
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 登出
- (void)httpRequestLogoutResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 修改密码
- (void)httpRequestModifyPasswordWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 首页专题推荐
- (void)httpRequestRecommendArticleResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 首页保险产品推荐
- (void)httpRequestRecommendInsuranceResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 忘记密码--发送验证码
- (void)httpRequestPasswordResetSmsCodeWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 忘记密码--重置密码
- (void)httpRequestPasswordResetWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;

@end
