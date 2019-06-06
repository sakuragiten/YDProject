//
//  LXNetworking.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXNetworking.h"
#import "LXHTTPSessionManager.h"
#import "LXNetwokingConfigManager.h"


#define HTTP_RETURNCODE_SUCCESS         200
//IM 请求成功的返回状态码
#define HTTP_RETURNCODE_IM_SUCCESS      @"C0000"

///api版本控制
static NSString* const apiVersion = @"2.2.0";

@interface LXNetworking ()


@end


@implementation LXNetworking


+ (void)setupAndConfigurationForNewWorking
{
    
    LXNetwokingConfigManager *config = [LXNetwokingConfigManager shareManager];
    
    [[LXHTTPSessionManager shareManager] settingSessionManager:^(AFHTTPSessionManager * _Nonnull manager) {
        
        AFHTTPRequestSerializer *serializer = manager.requestSerializer;
        
        NSString *user_agent = [NSString stringWithFormat:@"LXFindHouse%@:IOS%@:%@", config.appVersion, config.systemVersion, config.device];
        
        [serializer setValue:user_agent forHTTPHeaderField:@"User-Agent"];
        [serializer setValue:config.appVersion forHTTPHeaderField:@"version"];
        [serializer setValue:apiVersion forHTTPHeaderField:@"apiVersion"];
        
        ///浏览平台(1.安卓 2.IOS 3.PC 4.H5)
        [serializer setValue:@"2" forHTTPHeaderField:@"platform"];
        [serializer setValue:config.UUID forHTTPHeaderField:@"userUuid"];
    }];
}



+ (void)requestGetWithPath:(NSString *)path params:(NSDictionary *)params completionHandle:(LXRequestCompletionHandle)handle
{
    [self requestGetWithPath:path domainType:LXNetWorkingDomainNormal params:params completionHandle:handle];
}


+ (void)requestGetWithPath:(NSString *)path domainType:(LXNetWorkingDomainType)type params:(NSDictionary *)params completionHandle:(LXRequestCompletionHandle)handle
{
    [self requestWithPath:path domainType:type requestType:GET params:params completionHandle:handle];
}

+ (void)requestWithPath:(NSString *)path domainType:(LXNetWorkingDomainType)type requestType:(LXHTTPRequestType)requestType params:(NSDictionary *)params completionHandle:(LXRequestCompletionHandle)handle
{
    [[LXHTTPSessionManager shareManager] settingSessionManager:^(AFHTTPSessionManager * _Nonnull manager) {
        
        AFHTTPRequestSerializer *serializer = manager.requestSerializer;
        
        [serializer willChangeValueForKey:@"timeoutInterval"];
        serializer.timeoutInterval = 10;
        [serializer didChangeValueForKey:@"timeoutInterval"];
        
         //440300
        [serializer setValue:@"440300" forHTTPHeaderField:@"areaCode"];
    }];
    
    [[LXHTTPSessionManager shareManager] requestWithUrl:path
                        params:params
                   requestType:requestType
              completionHandle:^(BOOL success, id responseObj, NSError *error) {
                  
                  if (success) {
                      NSInteger returnCode = [responseObj[@"code"] integerValue];
                      NSString *statusCode = [NSString stringWithFormat:@"%@", [responseObj objectForKey:@"status"]];
                      NSString *msg = responseObj[@"desc"] ? : @"";
                      if (type == LXNetWorkingDomainIM) {
                          msg = responseObj[@"message"] ? : @"";
                      }
                      
                      if (returnCode == HTTP_RETURNCODE_SUCCESS || [statusCode isEqualToString:HTTP_RETURNCODE_IM_SUCCESS]) {
                          !handle ? : handle(YES, responseObj, nil);
                      } else {
                          !handle ? : handle(YES, responseObj, nil);
                          [self logFaileRequestWithPath:path params:params msg:msg];
                      }
                      
                  } else {
                      [self logFaileRequestWithPath:path params:params msg:error.userInfo.description];
                  }
        
    }];
}







+ (void)logFaileRequestWithPath:(NSString *)path params:(NSDictionary *)params msg:(NSString *)msg
{
    NSString *jsonString = @"nil";
    if (params) {
        NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        jsonString = [[NSString alloc] initWithData:paramsData encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"\n\n=====================requestInfo===============================\n\n"
          @"     url :  %@\n\n"
          @"  params :  %@\n\n"
          @"errorMsg :  %@\n\n"
          @"============================end=====================================\n\n -------", path, jsonString, msg);
}




@end
