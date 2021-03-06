//
//  CommonHttp.m
//  uavsystem
//
//  Created by jian zhang on 16/8/4.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonHttpAdapter.h"
#import <netinet/in.h>

static CommonHttpAdapter *comHttp = nil;

@implementation CommonHttpAdapter
{
    AFHTTPSessionManager *httpSessionManager;
    AFSecurityPolicy *securityPolicy;
    NSString *sessionString;
    NSString *m_BaseUrl;
}

+ (CommonHttpAdapter *)sharedCommonHttp
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comHttp = [[CommonHttpAdapter alloc] init];
    });
    return comHttp;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initAFNSession];
    }
    return self;
}

- (void)initAFNSession
{
    httpSessionManager = nil;
//    NSString *requsetType = @"https";
//    if (![DIF_CommonCurrentUser.serviceHost isEqualToString:@"192.168.100.243:51120"])
//    {
//        requsetType = @"http";
//    }
//    m_BaseUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/",requsetType,DIF_CommonCurrentUser.serviceHost,DIF_CommonCurrentUser.servicePort,DIF_CommonCurrentUser.serviceName];
//    m_BaseUrl = @"http://192.168.100.243:51120";
    httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
    [httpSessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    httpSessionManager.requestSerializer.timeoutInterval = 30;
    [httpSessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    AFJSONResponseSerializer *response = (AFJSONResponseSerializer *)httpSessionManager.responseSerializer;
    httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml",@"application/json", @"text/json", @"text/javascript",@"text/html",@"application/x-www-form-urlencoded", nil];
    response.removesKeysWithNullValues = YES;
//    if ([DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
//    {
//        [self setHttpsCertificate];
//    }
}

- (void)setBaseUrl
{
    NSString *requsetType = @"https";
    if (![DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
    {
        requsetType = @"http";
    }
    m_BaseUrl = [NSString stringWithFormat:@"%@://%@:%@/%@/",requsetType,DIF_CommonCurrentUser.serviceHost,DIF_CommonCurrentUser.servicePort,DIF_CommonCurrentUser.serviceName];
    [httpSessionManager setBaseURL:[NSURL URLWithString:m_BaseUrl]];
    if ([DIF_CommonCurrentUser.serviceHost isEqualToString:@"www.jlxxxfw.cn"])
    {
        [self setHttpsCertificate];
    }
}

-(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

- (void)setHttpsCertificate
{
    __block NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"appClient" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
//    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:cerData, nil];
    securityPolicy.pinnedCertificates = set;
    
    httpSessionManager.securityPolicy = securityPolicy;
}

- (NSString *)parametersToString:(NSDictionary *)params
{
    NSMutableString *paramString = [NSMutableString string];
    for (NSString *key in params.allKeys)
    {
        [paramString appendFormat:@"%@=%@",key,params[key]];
        [paramString appendString:@"&"];
    }
    [paramString deleteCharactersInRange:NSMakeRange(paramString.length-1, 1)];
    return paramString;
}

#pragma mark 获取请求对象
- (NSMutableURLRequest *)reWrteCreateHttpRequstWithMethod:(NSString *)model
                                                URLString:(NSString *)URLString
                                               parameters:(id)parameters
                                                  failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSError *serializationError = nil;
    
    NSMutableURLRequest *request;
    if ([model isEqualToString:@"GET"])
    {
        request =
        [httpSessionManager.requestSerializer requestWithMethod:model
                                                      URLString:[[NSURL URLWithString:URLString relativeToURL:httpSessionManager.baseURL] absoluteString]
                                                     parameters:parameters
                                                          error:&serializationError];

        
    }
    else
    {
        request =
        [[AFJSONRequestSerializer serializer] requestWithMethod:model
                                                      URLString:[[NSURL URLWithString:URLString relativeToURL:httpSessionManager.baseURL] absoluteString]
                                                     parameters:parameters
                                                          error:&serializationError];
    }
    if (serializationError)
    {
        if (failure)
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(httpSessionManager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        return nil;
    }
    
    
    if ([URLString rangeOfString:@"uc/api/brokeruser/token/refresh"].location != NSNotFound)
    {
        [request setValue:self.refresh_token forHTTPHeaderField:@"refreshToken"];
    }
    else if (self.access_token && self.access_token.length > 0)
    {
        [request setValue:self.access_token forHTTPHeaderField:@"accessToken"];
    }
    return request;
}

#pragma mark 获取请求事件并执行
- (NSURLSessionDataTask *)httpRequest:(NSURLRequest *)request
                             progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                              success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                              failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [httpSessionManager dataTaskWithRequest:request
                                        uploadProgress:uploadProgress
                                      downloadProgress:nil
                                     completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                         NSString * errorDes = error.userInfo[@"NSLocalizedDescription"];
                                         if (error)
                                         {
                                             if ([errorDes rangeOfString:@"401"].location != NSNotFound)
                                             {
                                                 if (success)
                                                 {
                                                     success(dataTask, responseObject);
                                                 }
                                             }
                                             else if ([responseObject count] == 2 && responseObject[@"code"])
                                             {
                                                 if (success)
                                                 {
                                                     success(dataTask, responseObject);
                                                 }
                                             }
                                             else
                                             {
                                                 if (failure)
                                                 {
                                                     failure(dataTask, error);
                                                 }
                                             }
                                         }
                                         else
                                         {
                                             if (success)
                                             {
                                                 success(dataTask, responseObject);
                                             }
                                         }
                                     }];
    [dataTask resume];
    return dataTask;
}

#pragma mark - Get请求
- (void)HttpGetRequestWithCommand:(NSString *)command
                       parameters:(NSDictionary *)parms
                    ResponseBlock:(CommonHttpResponseBlock)block
                      FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (![self connectedToNetwork])
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_NOT_HAVE_NETWORK):nil;
        return;
    }
    if (!command)
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
    if (parms)
    {
        command = [command stringByAppendingFormat:@"?%@",[self parametersToString:parms]];
    }
    DebugLog(@"command = %@",command);
    NSMutableURLRequest *request =
    [self reWrteCreateHttpRequstWithMethod:@"GET"
                                 URLString:[command stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                                parameters:nil
                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       DebugLog(@"error = %@",error);
                                       if (failedBlock)
                                       {
                                           failedBlock(error);
                                       }
                                   }];
    
    [self httpRequest:request
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  DebugLog(@"responseObject = %@",responseObject);
                  if (block)
                  {
                      if ([responseObject[@"code"] integerValue] == 604)
                      {
//                          [self refreshAccessTokenWithSuccessBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
//                              [self HttpGetRequestWithCommand:command parameters:parms ResponseBlock:block FailedBlcok:failedBlock];
//                          }];
                          DIF_POP_TO_LOGIN
                      }
                      else
                      {
                          block(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS,responseObject);
                      }
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DebugLog(@"error = %@",error);
                  if (failedBlock)
                  {
                      failedBlock(error);
                  }
              }];
}

#pragma mark - Post请求
- (void)HttpPostRequestWithCommand:(NSString *)command
                        parameters:(NSDictionary *)parms
                     ResponseBlock:(CommonHttpResponseBlock)block
                       FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (![self connectedToNetwork])
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_NOT_HAVE_NETWORK):nil;
        return;
    }
    if (!command)
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parms
//                                                       options:NSJSONWritingPrettyPrinted error:nil];
//    // NSData转为NSString
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    DebugLog(@"command = %@\nresponseObject = %@",command,jsonStr);
    NSMutableURLRequest *request =
    [self reWrteCreateHttpRequstWithMethod:@"POST"
                                 URLString:[command stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                                parameters:parms
                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       DebugLog(@"error = %@",error);
                                       if (failedBlock)
                                       {
                                           failedBlock(error);
                                       }
                                   }];
    
    [self httpRequest:request
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  DebugLog(@"responseObject = %@",responseObject);
                  if (block)
                  {
                      if ([responseObject[@"code"] integerValue] == 604)
                      {
//                          [self refreshAccessTokenWithSuccessBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
//                              [self HttpGetRequestWithCommand:command parameters:parms ResponseBlock:block FailedBlcok:failedBlock];
//                          }];
                          DIF_POP_TO_LOGIN 
                      }
                      else
                      {
                          block(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS,responseObject);
                      }
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DebugLog(@"error = %@",error);
                  if (failedBlock)
                  {
                      failedBlock(error);
                  }
              }];
}

#pragma mark - Put请求
- (void)HttpPutRequestWithCommand:(NSString *)command
                        parameters:(NSDictionary *)parms
                     ResponseBlock:(CommonHttpResponseBlock)block
                       FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (![self connectedToNetwork])
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_NOT_HAVE_NETWORK):nil;
        return;
    }
    if (!command)
    {
        block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
    DebugLog(@"command = %@",command);
    NSMutableURLRequest *request =
    [self reWrteCreateHttpRequstWithMethod:@"PUT"
                                 URLString:[command stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                                parameters:parms
                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       DebugLog(@"error = %@",error);
                                       if (failedBlock)
                                       {
                                           failedBlock(error);
                                       }
                                   }];
    
    [self httpRequest:request
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  DebugLog(@"responseObject = %@",responseObject);
                  if (block)
                  {
                      if ([responseObject[@"code"] integerValue] == 604)
                      {
//                          [self refreshAccessTokenWithSuccessBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
//                              [self HttpGetRequestWithCommand:command parameters:parms ResponseBlock:block FailedBlcok:failedBlock];
//                          }];
                          DIF_POP_TO_LOGIN
                      }
                      else
                      {
                          block(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS,responseObject);
                      }
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DebugLog(@"error = %@",error);
                  if (failedBlock)
                  {
                      failedBlock(error);
                  }
              }];
}

#pragma mark - 刷新accessToken

- (void)refreshAccessTokenWithSuccessBlock:(CommonHttpResponseBlock)block
{
//    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:51120"]];
    [self HttpPostRequestWithCommand:@"uc/api/brokeruser/token/refresh"
                          parameters:nil
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
                           {
                               NSDictionary *reulte = responseModel[@"result"];
                               DIF_CommonCurrentUser.accessToken = reulte[@"access_token"];
                               DIF_CommonCurrentUser.refreshToken = reulte[@"refresh_token"];
                               DIF_CommonHttpAdapter.access_token = DIF_CommonCurrentUser.accessToken;
                               DIF_CommonHttpAdapter.refresh_token = DIF_CommonCurrentUser.refreshToken;
                               block?block(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS, nil):[CommonHUD delayShowHUDWithMessage:@"秘钥已刷新，请重试"];
                           }
                           else
                           {
                               [CommonHUD delayShowHUDWithMessage:@"账户过期，请重新登录"];
//                               DIF_POP_TO_LOGIN
                           }
                       } FailedBlcok:^(NSError *error) {
                           [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
                       }];
}


#pragma mark - 取得公告附件下载路径
- (void)httpRequestDownloadFileByMobileWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"downloadFileByMobile.action"
                         parameters:parms
                      ResponseBlock:successBlock
                        FailedBlcok:failedBlock];
}

- (void)downLoadFileEventWithUrlString:(NSString *)urlPara
                          fieldTxtFile:(NSString *)filePath
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                        uploadProgress:(CommonHttpResponseProgress)progressBlock
{
    if (![self connectedToNetwork])
    {
        if (successBlock)
        {
            successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,@"网络连接失败\n请查看网络是否连接正常！");
        }
        return;
    }
    NSError *serializationError = nil;
    
    AFHTTPSessionManager *downLoadManger = [AFHTTPSessionManager manager];
    downLoadManger.responseSerializer = [AFJSONResponseSerializer serializer];
    downLoadManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSMutableURLRequest *request = [downLoadManger.requestSerializer
                                    requestWithMethod:@"GET"
                                    URLString:urlPara.mj_url.absoluteString
                                    parameters:nil
                                    error:&serializationError];
    __block NSURLSessionDownloadTask *dataTask =
    [downLoadManger downloadTaskWithRequest:request
                                   progress:^(NSProgress * _Nonnull downloadProgress) {
                                       if (progressBlock)
                                       {
                                           progressBlock(downloadProgress);
                                       }
                                   }
                                destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                    
                                    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                                    //使用建议的路径
                                    path = [path stringByAppendingPathComponent:@"/downloadFile"];
                                    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
                                    {
                                        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                                    }
                                    path = [path stringByAppendingPathComponent:filePath];
                                    InfoLog(@"%@",path);
                                    NSURL *url = [NSURL fileURLWithPath:path];
                                    return url;
                                }
                          completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                              if (successBlock)
                              {
                                  if (error == nil)
                                  {
                                      successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS,@{@"message":@"下载完成",
                                                                                           @"filePath":filePath.absoluteString});
                                  }
                                  else
                                  {//下载失败的时候，只列举判断了两种错误状态码
                                      NSString * message = nil;
                                      if (error.code == - 1005) {
                                          message = @"网络异常";
                                      }else if (error.code == -1001){
                                          message = @"请求超时";
                                      }else if (error.code == -1011){
                                          message = @"文件已过期";
                                      }else{
                                          message = @"未知错误";
                                      }
                                      successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,message);
                                      if (filePath && filePath.absoluteString.length > 0)
                                      {
                                          [[NSFileManager defaultManager] removeItemAtURL:filePath error:nil];
                                      }
                                  }
                              }
                          }];
    [dataTask resume];
}

#pragma mark - 个人中心
#pragma mark - 获取用户详情
- (void)httpRequestBrokerinfoWithResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/brokerinfo"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 修改个人信息
- (void)httpRequestModifyBrokerinfoWithParameters:(NSDictionary *)parms
                                    ResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPostRequestWithCommand:@"/api/brokerinfo"
                          parameters:parms
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if ([responseModel isKindOfClass:[NSDictionary class]] &&
                               [responseModel[@"code"] integerValue] == 200)
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                           }
                           else
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                           }
                           if (successBlock)
                           {
                               successBlock(type, responseModel);
                           }
                       }
                         FailedBlcok:failedBlock];
}
#pragma mark - 修改手机号码
- (void)httpRequestBrokerinfoPhoneWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPostRequestWithCommand:@"/api/brokerinfo/phone"
                          parameters:parms
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if ([responseModel isKindOfClass:[NSDictionary class]] &&
                               [responseModel[@"code"] integerValue] == 200)
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                           }
                           else
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                           }
                           if (successBlock)
                           {
                               successBlock(type, responseModel);
                           }
                       }
                         FailedBlcok:failedBlock];
}

#pragma mark - 我的订单
#pragma mark - 查询保险订单列表
- (void)httpRequestMyOrderInsuranceListWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
//    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:40002"]];
    [self HttpGetRequestWithCommand:@"/api/myorder/insurance/list"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 查询车险订单列表
- (void)httpRequestMyOrderCarListWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
//    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:40002"]];
    [self HttpGetRequestWithCommand:@"/api/myorder/car/list"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}

#pragma mark - 我的提现账户
#pragma mark - 我的全部提现账户列表
- (void)httpRequestMyAllAccountListWithParameters:(NSDictionary *)parms
                                    ResponseBlock:(CommonHttpResponseBlock)successBlock
                                      FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    //    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:40002"]];
    [self HttpGetRequestWithCommand:@"/api/withdrawalaccount/my/all"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 添加我的银行卡账户
- (void)httpRequestMyAcountAddBankCardWithParameters:(NSDictionary *)parms
                                       ResponseBlock:(CommonHttpResponseBlock)successBlock
                                         FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    //    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:40002"]];
    [self HttpPostRequestWithCommand:@"/api/withdrawalaccount/my/bankcard"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 修改银行卡账户
- (void)httpRequestMyAcountEditBankCardWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPutRequestWithCommand:@"/api/withdrawalaccount/bankcard"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 添加我的支付宝账户
- (void)httpRequestMyAcountAddAlipayWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPostRequestWithCommand:@"/api/withdrawalaccount/my/alipay"
                          parameters:parms
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if ([responseModel isKindOfClass:[NSDictionary class]] &&
                               [responseModel[@"code"] integerValue] == 200)
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                           }
                           else
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                           }
                           if (successBlock)
                           {
                               successBlock(type, responseModel);
                           }
                       }
                         FailedBlcok:failedBlock];
}
#pragma mark - 修改支付宝账号
- (void)httpRequestMyAcountEditAlipayWithParameters:(NSDictionary *)parms
                                     ResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPutRequestWithCommand:@"/api/withdrawalaccount/alipay"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}

#pragma mark - 提现申请
#pragma mark - 提现申请列表
- (void)httpRequestWithDrawalListWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    //    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:40002"]];
    [self HttpGetRequestWithCommand:@"/api/withdrawal"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}

#pragma mark - 我的邀请
#pragma mark - 我的邀请
- (void)httpRequestInviteListWithParameters:(NSDictionary *)parms
                              ResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/invite"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}

#pragma mark - 专题
#pragma mark - 专题分类
- (void)httpRequestArticleclassifyResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock

{
    [self HttpGetRequestWithCommand:@"/api/articleclassify"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 专题列表
- (void)httpRequestArticleListWithParameters:(NSDictionary *)parms
                               ResponseBlock:(CommonHttpResponseBlock)successBlock
                                 FailedBlcok:(CommonHttpResponseFailed)failedBlock

{
    [self HttpGetRequestWithCommand:@"/api/article"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 专题详情/常见问题详情
- (void)httpRequestArticleDetailWithParameters:(NSDictionary *)parms
                               ResponseBlock:(CommonHttpResponseBlock)successBlock
                                 FailedBlcok:(CommonHttpResponseFailed)failedBlock

{
    [self HttpGetRequestWithCommand:@"/api/article"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}

#pragma mark - 首页
#pragma mark - 通知公告列表
- (void)httpRequestIndexnNoticeResponseBlock:(CommonHttpResponseBlock)successBlock
                                 FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/indexnotice"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}

#pragma mark - 公告详情
- (void)httpRequestNoticeDetailWithParameters:(NSDictionary *)parms
                                ResponseBlock:(CommonHttpResponseBlock)successBlock
                                  FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/notice"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 轮播图列表
- (void)httpRequestMovePictureResponseBlock:(CommonHttpResponseBlock)successBlock
                                FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/movepicture"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 注册时获取验证码
- (void)httpRequestRegistrySmsCodeWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    NSString *command = @"/api/brokeruser/registry/smscode";
    command = [command stringByAppendingFormat:@"/{%@}", parms[@"brokerPhone"]];
    [self HttpGetRequestWithCommand:command
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 注册提交
- (void)httpRequestRegistryWithParameters:(NSDictionary *)parms
                            ResponseBlock:(CommonHttpResponseBlock)successBlock
                              FailedBlcok:(CommonHttpResponseFailed)failedBlock;
{
    [self HttpPostRequestWithCommand:@"/api/brokeruser/registry"
                          parameters:parms
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if ([responseModel isKindOfClass:[NSDictionary class]] &&
                               [responseModel[@"code"] integerValue] == 200)
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                           }
                           else
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                           }
                           if (successBlock)
                           {
                               successBlock(type, responseModel);
                           }
                       }
                         FailedBlcok:failedBlock];
}
#pragma mark - 登录时获取验证码
- (void)httpRequestSmsLoginSmsCodeWithParameters:(NSDictionary *)parms
                                   ResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    NSString *command = @"/api/brokeruser/smslogin/smscode";
    command = [command stringByAppendingFormat:@"/{%@}", parms[@"brokerPhone"]];
    [self HttpGetRequestWithCommand:command
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 短信验证码登录
- (void)httpRequestSmsLoginWithParameters:(NSDictionary *)parms
                            ResponseBlock:(CommonHttpResponseBlock)successBlock
                              FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPostRequestWithCommand:@"/api/brokeruser/smslogin"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 通过密码登录
- (void)httpRequestLoginWithParameters:(NSDictionary *)parms
                         ResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    if (!parms)
    {
        successBlock?successBlock(ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE,DIF_HTTP_REQUEST_PARMS_NULL):nil;
        return;
    }
    //    [httpSessionManager setBaseURL:[NSURL URLWithString:@"http://192.168.100.243:51120"]];
    DIF_WeakSelf(self)
    [self HttpPostRequestWithCommand:@"/uc/api/brokeruser/login"
                          parameters:parms
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if ([responseModel isKindOfClass:[NSDictionary class]] &&
                               [responseModel[@"code"] integerValue] == 200)
                           {
                               DIF_StrongSelf
                               strongSelf.refresh_token = responseModel[@"data"][@"refreshToken"][@"refreshToken"];
                               strongSelf.access_token = responseModel[@"data"][@"accessToken"][@"accessToken"];
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                           }
                           else
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                           }
                           if (successBlock)
                           {
                               successBlock(type, responseModel);
                           }
                       }
                         FailedBlcok:failedBlock];
}
#pragma mark - 登出
- (void)httpRequestLogoutResponseBlock:(CommonHttpResponseBlock)successBlock
                           FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/brokeruser/logout"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 修改密码
- (void)httpRequestModifyPasswordWithParameters:(NSDictionary *)parms
                                  ResponseBlock:(CommonHttpResponseBlock)successBlock
                                    FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpPostRequestWithCommand:@"/api/brokeruser/password/modify"
                         parameters:parms
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 首页专题推荐
- (void)httpRequestRecommendArticleResponseBlock:(CommonHttpResponseBlock)successBlock
                                     FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/recommend/article"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 首页保险产品推荐
- (void)httpRequestRecommendInsuranceResponseBlock:(CommonHttpResponseBlock)successBlock
                                       FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    [self HttpGetRequestWithCommand:@"/api/recommend/insuranceproduct"
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 忘记密码--发送验证码
- (void)httpRequestPasswordResetSmsCodeWithParameters:(NSDictionary *)parms
                                        ResponseBlock:(CommonHttpResponseBlock)successBlock
                                          FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    NSString *command = @"/api/password/reset/smscode";
    command = [command stringByAppendingFormat:@"/{%@}", parms[@"brokerPhone"]];
    [self HttpGetRequestWithCommand:command
                         parameters:nil
                      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                          if ([responseModel isKindOfClass:[NSDictionary class]] &&
                              [responseModel[@"code"] integerValue] == 200)
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                          }
                          else
                          {
                              type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                          }
                          if (successBlock)
                          {
                              successBlock(type, responseModel);
                          }
                      }
                        FailedBlcok:failedBlock];
}
#pragma mark - 忘记密码--重置密码
- (void)httpRequestPasswordResetWithParameters:(NSDictionary *)parms
                                 ResponseBlock:(CommonHttpResponseBlock)successBlock
                                   FailedBlcok:(CommonHttpResponseFailed)failedBlock
{
    NSString *command = @"/api/password/reset";
    [self HttpPostRequestWithCommand:command
                          parameters:parms
                       ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
                           if ([responseModel isKindOfClass:[NSDictionary class]] &&
                               [responseModel[@"code"] integerValue] == 200)
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS;
                           }
                           else
                           {
                               type = ENUM_COMMONHTTP_RESPONSE_TYPE_FAULSE;
                           }
                           if (successBlock)
                           {
                               successBlock(type, responseModel);
                           }
                       }
                         FailedBlcok:failedBlock];
}
@end
