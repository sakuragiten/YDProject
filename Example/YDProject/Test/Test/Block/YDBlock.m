//
//  YDBlock.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/2/20.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "YDBlock.h"

/** 截获变量 */

/**
 * 局部变量 （基本数据类型， 对象类型）
 * 对于基本数据类型的局部变量是截获其值
 * 对于对象类型的局部变量连同所有权修饰符一起截获
 */


/**
 * 静态局部变量
 * 以指针形式截获局部静态变量
 */


/** 不截获全局变量、静态全局变量 */

/**
 * 全局变量
 */

/**
 * 静态全局变量
 */




/**
 * 通过 【clang -rewrite-objc-fobjc-arc file.m】命令
 * 进行源码解析 看这些变量是如何截获的
 */

@implementation YDBlock

- (void)test
{
    YDTest *t = [YDTest new];
    t.age = 18;
    static int multiplier = 10;
    int (^Block)(int num) = ^int(int num) {
        NSLog(@"%ld", t.age);
        return  num * multiplier;
    };
    multiplier = 4;
    t.age = 21;
//    Block(2);
    NSLog(@"%d", Block(2));
}

@end
