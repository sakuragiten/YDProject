//
//  YDNetWorkManager.h
//  AFNetworking
//
//  Created by gongsheng on 2018/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDNetWorkManager : NSObject


+ (instancetype)sharedManager;

- (void)sendRequestWithUlr:(NSString *)url paramteres:(NSDictionary *)params isPost:(BOOL)isPost isCache:(BOOL)isCache completionHandle:(YDNewWorkHandle)handle;

@end

NS_ASSUME_NONNULL_END
