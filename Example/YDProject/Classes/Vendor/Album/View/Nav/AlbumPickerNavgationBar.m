//
//  AlbumPickerNavgationBar.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/5/28.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "AlbumPickerNavgationBar.h"

@implementation AlbumPickerNavgationBar

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    CGFloat height = 20;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (window.safeAreaInsets.top > 0) {
            height = window.safeAreaInsets.top;
        }
    }
    
    CGFloat navHeight = height + 44;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(0, 0, width, navHeight);
}
@end
