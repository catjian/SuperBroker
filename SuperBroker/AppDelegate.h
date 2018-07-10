//
//  AppDelegate.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BaseTabBarController *baseTB;

+ (AppDelegate *)sharedAppDelegate;

- (void)loadLoginViewController;

- (void)getHaveNewGridEventByTimer;


@end

