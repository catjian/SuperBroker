//
//  TIMManagerObject.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImSDK/ImSDK.h>

#define DIF_TIMManagerObject [TIMManagerObject sharedTIMManager]

typedef NS_ENUM(NSUInteger, ENUM_IM_CONTENT_TYPE) {
    ENUM_IM_CONTENT_TYPE_Send,
    ENUM_IM_CONTENT_TYPE_Recive,
};

@interface IMContentModel:NSObject

@property (nonatomic) ENUM_IM_CONTENT_TYPE type;
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, strong) NSString *userPicUrl;
@property (nonatomic, strong) NSString *messageTime;

@end

typedef void(^TIMManagerObjectReciveBlock)(void);

@interface TIMManagerObject : NSObject <TIMConnListener,TIMMessageListener,TIMUserStatusListener>

@property (nonatomic, strong) NSString* accountType;         // 用户的账号类型
@property (nonatomic, strong) NSString* identifier;              // 用户名
@property (nonatomic, strong) NSString* userSig;             // 鉴权Token
@property (nonatomic, strong) NSString* appidAt3rd;          // App用户使用OAuth授权体系分配的Appid
@property (nonatomic) int sdkAppId;           // 用户标识接入SDK的应用ID
@property (nonatomic, strong) NSMutableArray *IMContentArr;
@property (nonatomic, copy) TIMManagerObjectReciveBlock recBlock;

+ (TIMManagerObject *)sharedTIMManager;

- (void)loginEvent;

- (void)logoutEvent;

- (void)sendMessageWithText:(NSString *)message;
@end
