//
//  TIMManagerObject.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "TIMManagerObject.h"

static NSString *imContentSaveKey = @"imContentSaveKey";

@implementation IMContentModel

@end

static TIMManagerObject *objc = nil;

@implementation TIMManagerObject
{
    TIMManager *m_Manager;
}

+ (TIMManagerObject *)sharedTIMManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objc = [[TIMManagerObject alloc] init];
    });
    return objc;
}

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        self.IMContentArr = [NSMutableArray array];
        [self.IMContentArr setArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"imContentSaveKey"]];
        m_Manager = [TIMManager sharedInstance];
        [m_Manager setLogLevel:(TIM_LOG_NONE)];
        [m_Manager disableCrashReport];
        [m_Manager setConnListener:self];
        [m_Manager setMessageListener:self];
        [m_Manager setUserStatusListener:self];
//        [m_Manager initLogSettings:NO logPath:nil];
        [m_Manager initSdk:self.sdkAppId];
    }
    return self;
}

//- (void)setSdkAppId:(int)sdkAppId
//{
//    _sdkAppId = sdkAppId;
//    [m_Manager initSdk:sdkAppId];
//}

#pragma mark - Login & logout
- (void)getHistoryMessage
{
    TIMLoginParam *param = [[TIMLoginParam alloc] init];
    param.accountType = self.accountType;
    param.identifier = self.identifier;
    param.userSig = self.userSig;
    param.appidAt3rd = self.appidAt3rd;
    param.sdkAppId = self.sdkAppId;
    [m_Manager initStorage:param succ:^{
        
    } fail:^(int code, NSString *msg) {
        
    }];
}

- (void)loginEvent
{
    int err = [m_Manager initSdk:self.sdkAppId accountType:self.accountType];
    [self logoutEvent];
    TIMLoginParam *param = [[TIMLoginParam alloc] init];
    param.accountType = self.accountType;
    param.identifier = self.identifier;
    param.userSig = self.userSig;
    param.appidAt3rd = self.appidAt3rd;
    param.sdkAppId = self.sdkAppId;

    
//    [m_Manager login:self.identifier userSig:self.userSig succ:^{
//        NSLog(@"login succ");
//    } fail:^(int code, NSString *msg) {
//        NSLog(@"login fail: code=%d err=%@", code, msg);
//    }];
    [m_Manager login:param succ:^{
        NSLog(@"login succ");

    } fail:^(int code, NSString *msg) {
        NSLog(@"login fail: code=%d err=%@", code, msg);
    }];
}

- (void)loginWithSigEvent
{
    [m_Manager initSdk:self.sdkAppId];
    [self logoutEvent];
    [m_Manager login:self.identifier userSig:self.userSig succ:^{
        NSLog(@"login succ");
    } fail:^(int code, NSString *msg) {
        NSLog(@"login fail: code=%d err=%@", code, msg);
    }];
}

- (void)logoutEvent
{
    [m_Manager logout:^{
        NSLog(@"logout succ");
    } fail:^(int code, NSString *msg) {
                NSLog(@"logout fail: code=%d err=%@", code, msg);
    }];
}

#pragma mark - Send

- (void)sendMessageWithText:(NSString *)message
{
    IMContentModel *model = [IMContentModel new];
    model.type = ENUM_IM_CONTENT_TYPE_Send;
    model.contentStr = message;
    [self.IMContentArr addObject:[model mj_keyValues]];
    [[NSUserDefaults standardUserDefaults] setObject:self.IMContentArr forKey:@"imContentSaveKey"];
    TIMConversation * c2c_conversation = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:@"admin"];
    TIMTextElem * text_elem = [[TIMTextElem alloc] init];
    [text_elem setText:message];
    TIMMessage * msg = [[TIMMessage alloc] init];
    [msg addElem:text_elem];
    [c2c_conversation
     sendMessage:msg
     succ:^(){
         NSLog(@"SendMsg Succ");
     }fail:^(int code, NSString * err) {
         NSLog(@"SendMsg Failed:%d->%@", code, err);
         if (code == 6014)
         {
             [self loginWithSigEvent];
         }
     }];
}

#pragma mark - Connect Listener

- (void)onConnSucc
{
    
}

- (void)onConnFailed:(int)code err:(NSString *)err
{
    
}

- (void)onDisconnect:(int)code err:(NSString *)err
{
    
}

#pragma mark - Message Listener

- (void)onNewMessage:(NSArray *)msgs
{
    for (int i = 0; i < msgs.count; i++)
    {
        TIMMessage * message = [[TIMMessage alloc] init];
        message = msgs[i];
        int cnt = [message elemCount];
        for (int j = 0; j < cnt; j++)
        {
            TIMElem * elem = [message getElem:j];
            if ([elem isKindOfClass:[TIMTextElem class]])
            {
                TIMTextElem * text_elem = (TIMTextElem * )elem;
                IMContentModel *model = [IMContentModel new];
                model.type = ENUM_IM_CONTENT_TYPE_Recive;
                model.contentStr = text_elem.text;
                [self.IMContentArr addObject:[model mj_keyValues]];
                [[NSUserDefaults standardUserDefaults] setObject:self.IMContentArr forKey:@"imContentSaveKey"];
                if (self.recBlock)
                {
                    self.recBlock();
                }
            }
            else if ([elem isKindOfClass:[TIMImageElem class]])
            {
                TIMImageElem * image_elem = (TIMImageElem * )elem;
            }
        }
    }
}

#pragma mark - UserStatus Listener

- (void)onForceOffline
{
    
}

- (void)onUserSigExpired
{
    
}

@end
