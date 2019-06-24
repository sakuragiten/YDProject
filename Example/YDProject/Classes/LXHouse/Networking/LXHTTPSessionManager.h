//
//  LXHTTPSessionManager.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/16.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


typedef void(^LXRequestSessionHandle)(BOOL success, id responseObj, NSError *error);

typedef NS_ENUM(NSUInteger, LXHTTPRequestType){
    GET = 1,
    POST = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface LXHTTPSessionManager : NSObject


+ (instancetype)shareManager;


- (void)settingSessionManager:(void(^)(AFHTTPSessionManager *manager))handle;

- (void)requestWithUrl:(NSString *)url
                params:(NSDictionary *)params
           requestType:(LXHTTPRequestType)requestType
      completionHandle:(LXRequestSessionHandle)handle;




@end

NS_ASSUME_NONNULL_END
