//
//  OpenAlipaysViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "OpenAlipaysViewController.h"

@interface OpenAlipaysViewController () <WKNavigationDelegate>

@end

@implementation OpenAlipaysViewController
{
    WKWebView *m_webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [m_webView setNavigationDelegate:self];
    [self.view addSubview:m_webView];
//    NSString *urlStr = @"https://qr.alipay.com/bax06385q32ssucugqxm00f1";
    NSString *urlStr = BaseUrl;
    urlStr = [urlStr stringByAppendingString:@"api/memberlever/buy"];
    urlStr = [urlStr stringByAppendingFormat:@"?accesstoken=%@&levelId=%@&payType=alipay", DIF_CommonHttpAdapter.access_token, self.levelID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    //Cookies数组转换为requestHeaderFields
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    //设置请求头
    request.allHTTPHeaderFields = requestHeaderFields;
    [m_webView loadRequest:request];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]
                                       options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO}
                             completionHandler:^(BOOL success) {
        if (!success)
        {
            [CommonHUD delayShowHUDWithMessage:@"请先安装支付宝APP！" delayTime:2];
        }
        else
        {
            [CommonHUD hideHUD];
        }
    }];
}

// 在收到响应开始加载后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //返回支付宝的信息字符串，alipays:// 以后的为支付信息，这个信息后台是经过 URLEncode 后的，前端需要进行解码后才能跳转支付宝支付（坑点）
    
    //https://ds.alipay.com/?from=mobilecodec&scheme=alipays://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https%253A%252F%252Fqr.alipay.com%252Fbax041244dd0qf8n6ras805b%253F_s%253Dweb-other
    NSString *urlStr = [navigationResponse.response.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlStr containsString:@"alipays://"]) {
        
        [CommonHUD showHUDWithMessage:@"正在跳转到支付宝APP！"];
        NSRange range = [urlStr rangeOfString:@"alipays://"]; //截取的字符串起始位置
        NSString * resultStr = [urlStr substringFromIndex:range.location]; //截取字符串
        
        NSURL *alipayURL = [NSURL URLWithString:resultStr];
        
        [[UIApplication sharedApplication] openURL:alipayURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
            if (!success)
            {
                [CommonHUD delayShowHUDWithMessage:@"请先安装支付宝APP！" delayTime:2];
            }
            else
            {
                [CommonHUD hideHUD];
            }
        }];
    }
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}

@end
