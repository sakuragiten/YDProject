//
//  LXWebViewJSBridge.m
//  LXNewHouse
//
//  Created by LOUXUN-K on 2018/12/3.
//  Copyright © 2018 louxun. All rights reserved.
//

#import "LXWebViewJSBridge.h"

@implementation LXWebViewJSBridge
- (void)removeCompareHouse:(NSString *)data{
    if ([_delegate respondsToSelector:@selector(removeCompareHouse:)]) {
        [_delegate removeCompareHouse:data];
    }
}

- (void)addCompareHouse{
    if ([_delegate respondsToSelector:@selector(addCompareHouse)]) {
        [_delegate addCompareHouse];
    }
}

- (void)startNewHouse:(NSString *)data{
    if ([_delegate respondsToSelector:@selector(startNewHouse:)]) {
        [_delegate startNewHouse:data];
    }
}

- (void)startWebH5:(NSString *)data{
    if ([_delegate respondsToSelector:@selector(startWebH5:)]) {
        [_delegate startWebH5:data];
    }
}


- (void)openImage:(id)data img:(NSString *)img
{
    [_delegate openImage:data img:img];
}

- (void)aopenImage:(id)data
{
    [_delegate aopenImage:data];
}

@end
