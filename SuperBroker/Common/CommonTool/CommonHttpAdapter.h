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

//static NSString * const BaseUrl = @"https://malixi.51vip.biz:10326/";

static NSString * const BaseUrl = @"https://app.ybjfu.com/";



@interface CommonHttpAdapter : NSObject

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *refresh_token;

+ (CommonHttpAdapter *)sharedCommonHttp;

- (void)setBaseUrl:(NSString *)url;

-(BOOL) connectedToNetwork;

#pragma mark - 上传图片
/**
 上传图片
 
 @param image 图片
 @param successBlock 成功
 @param failedBlock 失败
 @return 图片URL
 */
- (NSString *)httpRequestUploadImageFile:(UIImage *)image
                           ResponseBlock:(CommonHttpResponseBlock)successBlock
                             FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 版本检查
- (void)httpRequestCheckVersionWithParameters:(NSDictionary *)parms
                                ResponseBlock:(CommonHttpResponseBlock)successBlock
                                  FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 字典表接口
- (void)httpRequestDictCodeWithCode:(NSString *)code
                      ResponseBlock:(CommonHttpResponseBlock)successBlock
                        FailedBlcok:(CommonHttpResponseFailed)failedBlock;

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
#pragma mark - 发送修改手机号码短信验证码
- (void)httpRequestBrokerinfoSmsCodeWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 意见反馈保存
- (void)httpRequestBrokerFeedBackWithParameters:(NSDictionary *)parms
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
#pragma mark - 保险订单详情
- (void)httpRequestMyOrderInsuranceDetailWithParameters:(NSDictionary *)parms
                                          ResponseBlock:(CommonHttpResponseBlock)successBlock
                                            FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 车险订单详情
- (void)httpRequestMyOrderCarDetailWithParameters:(NSDictionary *)parms
                                    ResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 取消订单
- (void)httpRequestMyOrderCancelWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 车险订单付款
- (void)httpRequestMyOrderCarPayWithParameters:(NSDictionary *)parms
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
#pragma mark - 获取银行列表
- (void)httpRequestBankListResponseBlock:(CommonHttpResponseBlock)successBlock
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
#pragma mark - 保存提现申请
- (void)httpRequestWithDrawalRequestWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 提现申请页面的数据：提现账户/提现规则
- (void)httpRequestWithDrawalInfoWithResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 收益
#pragma mark - 我的收益流水
- (void)httpRequestMyBrokerIncomeListWithParameters:(NSDictionary *)parms
                                      ResponseBlock:(CommonHttpResponseBlock)successBlock
                                        FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的钱包 - 我的收益与我的消费券公用，显示总额
- (void)httpRequestMyBrokerAmountResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的消费券流水
- (void)httpRequestMyrokercCouponListWithParameters:(NSDictionary *)parms
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
#pragma mark - 常见问题列表
- (void)httpRequestCommonProblemListWithParameters:(NSDictionary *)parms
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
#pragma mark - 首页专题推荐
- (void)httpRequestRecommendArticleResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 首页保险产品推荐
- (void)httpRequestRecommendInsuranceResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 首页接口合集（保险产品/专题/贷款产品/轮播图）
- (void)httpRequestRecommendRootAllResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 登录注册
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
#pragma mark - 忘记密码--发送验证码
- (void)httpRequestPasswordResetSmsCodeWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 忘记密码--重置密码
- (void)httpRequestPasswordResetWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 消息
#pragma mark - 消息列表
- (void)httpRequestNoticeListWithParameters:(NSDictionary *)parms
                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 消息详情 公告详情
- (void)httpRequestMessageNoticeDetailWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 保险产品
#pragma mark - 获取全部保险公司
- (void)httpRequestInsuranceCompanyResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 获取所有险种
- (void)httpRequestInsuranceSpeciesResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 险种筛选页面数据
- (void)httpRequestInsuranceFiltrateResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 保险列表
- (void)httpRequestInsuranceProductListWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 保险产品详情
- (void)httpRequestInsuranceProductDetailWithParameters:(NSDictionary *)parms
                                          ResponseBlock:(CommonHttpResponseBlock)successBlock
                                            FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 购买保险
- (void)httpRequestInsuranceOrderWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 车险产品
#pragma mark - 车险商品列表
- (void)httpRequestInsuranceCarProductListResponseBlock:(CommonHttpResponseBlock)successBlock
                                            FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 车险产品对应的险种列表
- (void)httpRequestCarSpeciesListWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 车险订单保存
- (void)httpRequestCarOrderWithParameters:(NSDictionary *)parms
                            ResponseBlock:(CommonHttpResponseBlock)successBlock
                              FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 车险产品详情
- (void)httpRequestInsuranceCarProductDetailWithParameters:(NSDictionary *)parms
                                          ResponseBlock:(CommonHttpResponseBlock)successBlock
                                            FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 会员购买
#pragma mark - 会员等级列表
- (void)httpRequestMemberLevelResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的权益
- (void)httpRequestMemberLeverMyLevelResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 购买会员
- (void)httpRequestMemberLeverBuyWithParameters:(NSDictionary *)parms
                            ResponseBlock:(CommonHttpResponseBlock)successBlock
                              FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的会员购买订单
- (void)httpRequestMemberLeverMyOrderResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 客服
#pragma mark - 获取userSig
- (void)httpRequestUserSigResponseBlock:(CommonHttpResponseBlock)successBlock
                            FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 贷款
#pragma mark - 贷款列表
- (void)httpRequestLoanproductListWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 贷款详情
- (void)httpRequestLoanproductDetailWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 贷款保存订单
- (void)httpRequestLoanOrderWithParameters:(NSDictionary *)parms
                             ResponseBlock:(CommonHttpResponseBlock)successBlock
                               FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 贷款资质列表
- (void)httpRequestLoanproductSpeciesWithParameters:(NSDictionary *)parms
                                      ResponseBlock:(CommonHttpResponseBlock)successBlock
                                        FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 我的贷款订单列表
- (void)httpRequestMyloanListWithParameters:(NSDictionary *)parms
                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的贷款订单详情
- (void)httpRequestMyloanOrderDetailWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的贷款取消贷款订单
- (void)httpRequestMyloanCancelOrderWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;

#pragma mark - 我的业绩
#pragma mark - 我的推广业绩
- (void)httpRequestMyPerformanceMemberWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的保险业绩
- (void)httpRequestMyPerformanceSafeWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock;
#pragma mark - 我的贷款业绩
- (void)httpRequestMyPerformanceCreditWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock;
@end
