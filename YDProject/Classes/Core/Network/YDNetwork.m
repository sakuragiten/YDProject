//
//  YDNetwork.m
//  YDProject
//
//  Created by gongsheng on 2018/11/7.
//

#import "YDNetwork.h"
#import "YDNetWorkManager.h"

@implementation YDNetwork

+ (void)sendGETReuqestWithUrl:(NSString *)url paramteres:(NSDictionary *)params completionHandle:(YDNewWorkHandle)handle
{
    [self sendRequestWithUlr:url paramteres:params isPost:NO isCache:NO completionHandle:handle];
}



+ (void)sendRequestWithUlr:(NSString *)url paramteres:(NSDictionary *)params isPost:(BOOL)isPost isCache:(BOOL)isCache completionHandle:(YDNewWorkHandle)handle
{
    [[YDNetWorkManager sharedManager] sendRequestWithUlr:url paramteres:params isPost:isPost isCache:isCache completionHandle:handle];
}




@end
