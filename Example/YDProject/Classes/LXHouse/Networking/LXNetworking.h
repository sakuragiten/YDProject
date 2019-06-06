//
//  LXNetworking.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef void(^LXRequestCompletionHandle)(BOOL success, id responseObject, NSString *errorMsg);


typedef NS_ENUM(NSUInteger, LXNetWorkingDomainType){
    LXNetWorkingDomainNormal = 0,
    LXNetWorkingDomainIM = 1,
};



@interface LXNetworking : NSObject



/** 初始化设置 */
+ (void)setupAndConfigurationForNewWorking;

/**
 GET 请求
 
 @param path 请求的url
 @param params 请求参数
 @param handle 请求完成的回调
 */
+ (void)requestGetWithPath:(NSString *)path
                    params:(NSDictionary *)params
          completionHandle:(LXRequestCompletionHandle)handle;





/**
 GET 请求

 @param path 请求的url
 @param type 域名类型
 @param params 请求参数
 @param handle 请求完成的回调
 */
+ (void)requestGetWithPath:(NSString *)path
                domainType:(LXNetWorkingDomainType)type
                    params:(NSDictionary *)params
          completionHandle:(LXRequestCompletionHandle)handle;














@end

