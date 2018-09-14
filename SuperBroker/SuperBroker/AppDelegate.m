 //
//  AppDelegate.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AppDelegate.h"
#import "TIMManagerObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    LoginViewController *m_LoginVC;
    NSDictionary *m_VersionDic;
}



+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMConfigure setLogEnabled:NO];//此处在初始化函数前面是为了打印初始化的日志
    [MobClick setCrashReportEnabled:YES];
    [UMConfigure initWithAppkey:@"5b5eb685b27b0a4a24000112" channel:@"App Store"];
    
    // U-Share 平台设置
    [self configUSharePlatforms];
    [self confitUShareSettings];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    [self loadWindowRootTabbarViewController];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:DIF_Login_Status] != 1)
    {
        [self performSelector:@selector(loadLoginViewController) withObject:nil afterDelay:.5];
    }
    else
    {
        DIF_CommonHttpAdapter.access_token = DIF_CommonCurrentUser.accessToken;
        DIF_CommonHttpAdapter.refresh_token = DIF_CommonCurrentUser.refreshToken;
//        [self httpRequestIMUserSig];
        [self performSelector:@selector(httpRequestIMUserSig) withObject:nil afterDelay:1];
        [self httpRequestMyBrokerAmount];
    }
    [self.window makeKeyAndVisible];
    [self performSelector:@selector(httpRequestCheckVersion) withObject:nil afterDelay:1];
    
//    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults] synchronize];
    [DIF_TIMManagerObject logoutEvent];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [DIF_TIMManagerObject loginEvent];
    [self showUpdataAlert];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//数据字典列表
- (NSDictionary *)serviceKeyValue
{
    return @{@"1":@"车险订单", @"2":@"保险订单",
             @"3":@"会员订单(2999)", @"4":@"会员订单(4999)", @"5":@"会员订单(6999)",
             @"6":@"6999会员", @"7":@"4999会员", @"8":@"2999会员",
             @"9":@"付费会员", @"10":@"企业会员",
             @"11":@"待付款", @"12":@"待报价", @"13":@"待确认",
             @"14":@"待审核", @"15":@"已完成", @"16":@"结算中",
             @"17":@"已取消", @"18":@"已关闭", @"19":@"待打款",
             @"20":@"已完成",
             @"21":@"失败", @"22":@"启用", @"23":@"停用",
             @"24":@"停用", @"25":@"启用", @"26":@"外部", @"27":@"内部",
             @"28":@"运营中心提现", @"29":@"代理商提现", @"30":@"会员提现",
             @"31":@"没有填写佣金", @"32":@"运营中心缴费", @"33":@"代理商缴费",
             @"34":@"中国银行", @"35":@"建设银行", @"36":@"工商银行",
             @"37":@"农业银行", @"38":@"招商银行", @"39":@"中信银行",
             @"40":@"银行卡", @"41":@"支付宝",
             @"42":@"没经纪人比率",
             @"45":@"消费型",
             @"46":@"返还型",
             @"47":@"银行卡",
             @"48":@"支付宝",
             @"49":@"汽油",
             @"50":@"柴油",
             @"51":@"企业会员收益",
             @"52":@"个人会员收益",
             @"55":@"默认排序",
             @"56":@"时间排序",
             @"57":@"不限",
             @"58":@"不限年龄",
             @"59":@"0-17周岁",
             @"60":@"18-65周岁",
             @"61":@"66-100周岁",
             @"62":@"系统消息",
             @"63":@"财富消息",
             @"64":@"非付费会员",
             @"65":@"已取消",
             @"66":@"顶级经纪人",
             @"68":@"申请中",
             @"69":@"处理中",
             @"70":@"成功",
             @"71":@"取消",
             @"72":@"失败",
             @"73":@"基础分润组"
             };
}

#pragma mark - Custom Function

- (void)loadWindowRootTabbarViewController
{
    RootViewController *rootVC = [[RootViewController alloc] init];
    BaseNavigationViewController *nav1 = [[BaseNavigationViewController alloc] initWithRootViewController:rootVC];
    
    SpecialNewsViewController *snVC = [[SpecialNewsViewController alloc] init];
    BaseNavigationViewController *nav2 = [[BaseNavigationViewController alloc] initWithRootViewController:snVC];
    
    MessageViewController *msgVC = [[MessageViewController alloc] init];
    BaseNavigationViewController *nav3 = [[BaseNavigationViewController alloc] initWithRootViewController:msgVC];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    BaseNavigationViewController *nav4 = [[BaseNavigationViewController alloc] initWithRootViewController:myVC];
    
    self.baseTB = [[BaseTabBarController alloc] initWithViewControllers:@[nav1,nav2,nav3,nav4]];
    [self.window setRootViewController:self.baseTB];
}

- (void)loadLoginViewController
{
    [CommonHUD hideHUD];
    m_LoginVC = [[LoginViewController alloc] init];
    BaseNavigationViewController *navc = [[BaseNavigationViewController alloc] initWithRootViewController:m_LoginVC];
    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
}

#pragma mark - share

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    BOOL isSucWX = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:@"wxee23b4575bed6a75"
                                       appSecret:@"42653bd4124e6889f3dbedc2a233b180"
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置QQ的appKey和appSecret */
    BOOL isSucQQ = [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                                         appKey:@"1107768203"
                                                      appSecret:@"1clPhLwpEiqtTx03"
                                                    redirectURL:nil];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:@"1581588422App"
                                       appSecret:@"8caf98dfb760302b6067e69d8c57671c"
                                     redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                         URLString:(NSString *)string
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                         shareObjectWithTitle:@"@我，这是我的独门签单秘籍，开单宝典送给努力前行的你"
                                         descr:@"您的好友在易普惠分享一起开单大吉，邀您开单送大礼！"
                                         thumImage:[UIImage imageNamed:@"AppIcon"]];
    //设置网页地址
    shareObject.webpageUrl =string;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager]
     shareToPlatform:platformType
     messageObject:messageObject
     currentViewController:self.baseTB
     completion:^(id data, NSError *error) {
         if (error) {
             NSLog(@"************Share fail with error %@*********",error);
         }else{
             NSLog(@"response data is %@",data);
         }
     }];
}

#pragma mark - Http Request
- (void)httpRequestIMUserSig
{
    [DIF_CommonHttpAdapter
     httpRequestUserSigResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             NSDictionary *dic = responseModel[@"data"];
             DIF_APPDELEGATE.imUserSig = dic;
             NSNumber *number = dic[@"accountType"];
             [TIMManagerObject sharedTIMManager].accountType = [number stringValue];
             DIF_TIMManagerObject.identifier = dic[@"identifier"];
             DIF_TIMManagerObject.userSig = dic[@"userSig"];
             number = dic[@"sdkAppID"];
             DIF_TIMManagerObject.appidAt3rd = [number stringValue];
             DIF_TIMManagerObject.sdkAppId = [number intValue];
             [DIF_TIMManagerObject loginEvent];
         }
     } FailedBlcok:^(NSError *error) {
         
     }];
}

- (void)httpRequestMyBrokerAmount
{
    [DIF_CommonHttpAdapter
     httpRequestMyBrokerAmountResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             NSDictionary *dic = responseModel[@"data"];
             DIF_APPDELEGATE.mybrokeramount = dic;
         }
     } FailedBlcok:^(NSError *error) {
         
     }];
}

- (void)httpRequestGetBrokerInfo
{
    [CommonHUD showHUD];
    [DIF_CommonHttpAdapter
     httpRequestBrokerinfoWithResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_APPDELEGATE.brokerInfoModel = [BrokerInfoDataModel mj_objectWithKeyValues:responseModel[@"data"]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestCheckVersion
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestCheckVersionWithParameters:@{@"versionCode": [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             DIF_StrongSelf
             [CommonHUD hideHUD];
             strongSelf->m_VersionDic = responseModel[@"data"];
             [strongSelf showUpdataAlert];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)showUpdataAlert
{
    DIF_WeakSelf(self)
    if ([m_VersionDic[@"isLatest"] boolValue])
    {
        UIAlertController *alert =
        [CommonAlertView showAlertViewWithTitle:@"版本更新提示"
                                        Message:m_VersionDic[@"updateInfo"]
                                   NormalButton:nil
                                   CancelButton:@"更新"
                                   NormalHander:^(UIAlertAction *action) {
                                       DIF_StrongSelf
                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strongSelf->m_VersionDic[@"downloadUrl"]]
                                                                          options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO}
                                                                completionHandler:^(BOOL success) {
                                                                    if (!success)
                                                                    {
                                                                        [CommonHUD delayShowHUDWithMessage:@"请先安装Safari" delayTime:2];
                                                                        [strongSelf showUpdataAlert];
                                                                    }
                                                                    else
                                                                    {
                                                                        [CommonHUD hideHUD];
                                                                    }
                                                                }];
                                   }];
        if ([[NSUserDefaults standardUserDefaults] integerForKey:DIF_Login_Status] != 1)
        {
            [m_LoginVC presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    }
}

@end
