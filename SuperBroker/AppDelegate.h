//
//  AppDelegate.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DIF_Login_Status @"DIF_Login_Status"
#define DIF_Loaction_Save_UserId @"DIF_Loaction_Save_UserId"
#define DIF_Loaction_Save_Password @"DIF_Loaction_Save_Password"

typedef NS_ENUM(NSUInteger, ENUM_MyOrder_Status) {
    ENUM_MyOrder_Status_WaitPay = 11,
    ENUM_MyOrder_Status_WaitConfirm = 13,
    ENUM_MyOrder_Status_Finish = 15
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BaseTabBarController *baseTB;

+ (AppDelegate *)sharedAppDelegate;

- (void)loadLoginViewController;


@end

