//
//  DIsposeViewModel.m
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/3.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "DIsposeViewModel.h"

@implementation DIsposeViewModel

static DIsposeViewModel *_shared = nil;
+ (instancetype)shared {
    if (_shared == nil) {
        _shared = [DIsposeViewModel new];
    }
    return  _shared;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (RACSubject *)subject {
    if (!_subject){
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end
