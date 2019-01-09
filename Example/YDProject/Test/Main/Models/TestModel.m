//
//  TestModel.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className
{
    if (self = [super init]) {
        self.title = title;
        self.className = className;
    }
    
    return self;
}

@end
