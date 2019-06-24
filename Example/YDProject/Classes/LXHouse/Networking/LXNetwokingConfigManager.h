//
//  LXNetwokingConfigManager.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXNetwokingConfigManager : NSObject

/** app version */
@property (nonatomic, copy) NSString *appVersion;

/** device systemVersion */
@property (nonatomic, copy) NSString *systemVersion;

/** device name */
@property (nonatomic, copy) NSString *device;

/** UUID */
@property (nonatomic, copy) NSString *UUID;

/** app comment URL in Itunes */
@property (nonatomic, copy) NSString *commentUrl;



+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
