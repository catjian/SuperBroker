//
//  AppDelegate.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMConfigure setLogEnabled:NO];//此处在初始化函数前面是为了打印初始化的日志
//    [MobClick setCrashReportEnabled:YES];
//    [UMConfigure initWithAppkey:@"5b44b282a40fa3138b000155" channel:@"App Store"];
    
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
    }
    [self.window makeKeyAndVisible];
    
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    LoginViewController *vc = [[LoginViewController alloc] init];
    BaseNavigationViewController *navc = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
}

@end
