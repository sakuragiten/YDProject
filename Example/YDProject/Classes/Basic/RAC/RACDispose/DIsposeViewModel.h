//
//  DIsposeViewModel.h
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/3.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DIsposeViewModel : NSObject

@property (nonatomic, strong) RACSubject *subject;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
