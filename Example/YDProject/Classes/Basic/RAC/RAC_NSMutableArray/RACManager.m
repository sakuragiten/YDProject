//
//  RACManager.m
//  YDProject_Example
//
//  Created by 热心市民小龚 on 2023/2/8.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "RACManager.h"

@implementation RACManager


static RACManager *_manager = nil;

+ (instancetype)shared {
    if (!_manager) {
        _manager = [RACManager new];
    }
    return _manager
    ;
}

@end
