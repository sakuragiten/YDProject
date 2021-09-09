//
//  YDNetwork.h
//  YDProject
//
//  Created by gongsheng on 2018/11/7.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

typedef void (^YDNewWorkHandle)(BOOL success, id responseObject, NSError *error);

@interface YDNetwork : NSObject




/** GET请求 */
+ (void)sendGETReuqestWithUrl:(NSString *)url
                         paramteres:(NSDictionary *)params
                   completionHandle:(YDNewWorkHandle)handle;





@end

//NS_ASSUME_NONNULL_END
