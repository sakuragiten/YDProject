//
//  OSUnfairLockDemo.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/12/23.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@interface OSUnfairLockDemo ()
@property (assign, nonatomic) os_unfair_lock lock;
@property (assign, nonatomic) os_unfair_lock lock1;
@end

@implementation OSUnfairLockDemo





- (instancetype)init
{
    if (self = [super init]) {
        // 初始化锁
        self.lock = OS_UNFAIR_LOCK_INIT;
        self.lock1 = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}







/**
 存钱
 */
- (void)saveMoney
{
    os_unfair_lock_lock(&_lock);
    [super saveMoney];
    os_unfair_lock_unlock(&_lock);
}


/**
 取钱
 */
- (void)drawMoney
{
    os_unfair_lock_lock(&_lock);
    [super drawMoney];
    os_unfair_lock_unlock(&_lock);
}



/**
 卖1张票
 */

- (void)saleTicket
{
    os_unfair_lock_lock(&_lock1);
    [super saleTicket];
    os_unfair_lock_unlock(&_lock1);
}




@end
