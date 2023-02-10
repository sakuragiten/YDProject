//
//  NSMutableArray+RAC.h
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/7.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (RAC)

- (RACSignal *)rac_elementSignal;

@end

NS_ASSUME_NONNULL_END
