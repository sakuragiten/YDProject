//
//  RACManager.h
//  YDProject_Example
//
//  Created by 热心市民小龚 on 2023/2/8.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACManager : NSObject

+ (instancetype)shared;

@property (nonatomic, weak) NSMutableArray *array;

@end

NS_ASSUME_NONNULL_END
