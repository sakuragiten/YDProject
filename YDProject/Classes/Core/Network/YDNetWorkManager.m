//
//  YDNetWorkManager.m
//  AFNetworking
//
//  Created by gongsheng on 2018/11/7.
//

#import "YDNetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
@interface YDNetWorkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;

@end

@implementation YDNetWorkManager



static YDNetWorkManager *_manager = nil;
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [YDNetWorkManager new];
    });
    return _manager;
}


- (void)sendRequestWithUlr:(NSString *)url paramteres:(NSDictionary *)params isPost:(BOOL)isPost isCache:(BOOL)isCache completionHandle:(YDNewWorkHandle)handle
{
    [self.httpSessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handle) handle(YES, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (handle) handle(NO, nil, error);
    }];
}



- (AFHTTPSessionManager *)httpSessionManager
{
    if (!_httpSessionManager) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        requestSerializer.timeoutInterval = 30;
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"application/xml", nil];
        
        _httpSessionManager.requestSerializer = requestSerializer;
        _httpSessionManager.responseSerializer = responseSerializer;
    }
    
    return _httpSessionManager;
}


@end
