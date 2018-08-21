//
//  YuLoginRegisterUtilities.h
//  HuLaQuan
//
//  Created by hok on 1/6/16.
//  Copyright © 2018 Jianghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonVerify : NSObject

+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isIPHost:(NSString *)host;

+ (BOOL)verifyPasswod:(NSString *)password;

+(BOOL)isContainsEmoji:(NSString *)string;
//身份证
+ (BOOL)isIdentityCard:(NSString *)identityCard;

+(BOOL)stringIsRangingString:(NSString *)stringA :(NSString *)stringB;

+ (BOOL)isBankCardId:(NSString *)bankCard;

@end
