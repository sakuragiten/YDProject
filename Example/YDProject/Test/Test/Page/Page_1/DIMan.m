//
//  DIMan.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/3/1.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "DIMan.h"

@implementation DIMan


- (instancetype)initWithName:(NSString *)name
{
    return [self initWithAge:@"23"];
}

- (instancetype)initWithAge:(NSString *)age
{
    if (self = [super initWithName:@"man"]) {
        self.age = age;
    }
    return self;
}

@end
