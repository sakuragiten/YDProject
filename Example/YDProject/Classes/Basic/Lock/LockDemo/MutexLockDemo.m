//
//  MutexLockDemo.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/12/23.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "MutexLockDemo.h"
#import <pthread.h>

@interface MutexLockDemo ()
@property (assign, nonatomic) pthread_mutex_t lock;
@property (assign, nonatomic) pthread_mutex_t lock1;
@end

@implementation MutexLockDemo





- (instancetype)init
{
    if (self = [super init]) {
        // 初始化锁
        // #define PTHREAD_MUTEX_INITIALIZER {_PTHREAD_MUTEX_SIG_init, {0}}
//        self.lock = PTHREAD_MUTEX_INITIALIZER;
//        self.lock1 = PTHREAD_MUTEX_INITIALIZER;
        // 这儿调用了setter方法 不允许这样写，语法不通过 定义的时候可以赋值初始化
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
        pthread_mutex_init(&_lock, &attr);
        pthread_mutex_init(&_lock1, &attr);
        
        // 销毁属性
        pthread_mutexattr_destroy(&attr);
        
        
        /**
         #define PTHREAD_MUTEX_NORMAL        0
         #define PTHREAD_MUTEX_ERRORCHECK    1
         #define PTHREAD_MUTEX_RECURSIVE        2
         #define PTHREAD_MUTEX_DEFAULT
         */
        
        /**
         pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
         相当于
         pthread_mutexattr_settype(&attr,  NULL);
         */
        
    }
    return self;
}







/**
 存钱
 */
- (void)saveMoney
{
    pthread_mutex_lock(&_lock);
    [super saveMoney];
    pthread_mutex_unlock(&_lock);
}


/**
 取钱
 */
- (void)drawMoney
{
    pthread_mutex_lock(&_lock);
    [super drawMoney];
    pthread_mutex_unlock(&_lock);
}



/**
 卖1张票
 */

- (void)saleTicket
{
    pthread_mutex_lock(&_lock1);
    [super saleTicket];
    pthread_mutex_unlock(&_lock1);
}


- (void)dealloc
{
    pthread_mutex_destroy(&_lock);
    pthread_mutex_destroy(&_lock1);
}



@end

