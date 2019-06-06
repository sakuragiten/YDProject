//
//  LXNetwokingConfigManager.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXNetwokingConfigManager.h"

#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>

#import <SAMKeychain/SAMKeychain.h>


@implementation LXNetwokingConfigManager


static LXNetwokingConfigManager *_manager = nil;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [LXNetwokingConfigManager new];
        
        [_manager initialProperties];
    });
    
    return _manager;
}


- (void)initialProperties
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    _appVersion = info[@"CFBundleShortVersionString"];
    _device = [self getDeviceModelName];
    _UUID = [self getUUID];
    _systemVersion = [UIDevice currentDevice].systemVersion;
    
}

- (NSString *)getDeviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone_X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone_X";
    
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    return deviceModel;
}

///获取设备UUID
- (NSString *)getUUID{
    
    static NSString * const LXService = @"com.louxun.LXFindHouse";
    static NSString * const LXUUIDKey = @"LXUUIDKey";
    
    NSString *uuid = [SAMKeychain passwordForService:LXService account:LXUUIDKey];
    if (uuid.length == 0) {
        //uuid不存在 生成UUID
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);

        [SAMKeychain setPassword:[self md5StringWithString:uuid] forService:LXService account:LXUUIDKey];
    }
    
    return uuid;
}

//32位十六进制
-(NSString *)md5StringWithString:(NSString *)baseString
{
    if (!baseString || [baseString length] == 0) return @"";
    
    const char *cStr = [baseString UTF8String];
    unsigned char result[32];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    NSString * resultStr = [NSString stringWithFormat:
                            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]
                            ];
    return [resultStr lowercaseString];
}

@end
