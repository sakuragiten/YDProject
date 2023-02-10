//
//  OSSpinLockDemo.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/12/23.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "OSSpinLockDemo.h"

#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo ()
@property (assign, nonatomic) OSSpinLock lock;
@property (assign, nonatomic) OSSpinLock lock1;
@end

@implementation OSSpinLockDemo


//----------------------------------------
// part 1 用自旋锁解决购票问题
//----------------------------------------

//[self ticketTest];




//----------------------------------------
// 购票场景 只有一个方法 也就是买票的方法 saleTicket1 --> saleTicket2 可以完成需求
// 如果是存钱取钱两个操作同时进行呢？？
// 思考这个问题的关键是 看操作能否同时进行，很明显 存钱、取钱的操作不能同时进行，故，只能用一把锁
//
// part 2 用自旋锁解决存钱取钱问题
//----------------------------------------

/**
 saveMoney1 会有问题 因为两把锁 只能保证对应的操作只有一条线程在执行
 saveMoney2 可以解决  访问同一块资源需要同一把锁来控制
 */



- (instancetype)init
{
    if (self = [super init]) {
        // 初始化锁
        self.lock = OS_SPINLOCK_INIT;
        self.lock1 = OS_SPINLOCK_INIT;
    }
    return self;
}







/**
 存钱
 */
- (void)saveMoney
{
    // 加锁
    OSSpinLockLock(&_lock);

    [super saveMoney];
    
    // 解锁
    OSSpinLockUnlock(&_lock);
}


/**
 取钱
 */
- (void)drawMoney
{
    // 加锁
    OSSpinLockLock(&_lock);
    
    [super drawMoney];
    // 解锁
    OSSpinLockUnlock(&_lock);
}

/*
 thread1：优先级比较高
 
 thread2：优先级比较低
 
 thread3
 
 线程的调度，10ms
 
 时间片轮转调度算法（进程、线程）
 线程优先级
 */

/**
 卖1张票
 */

- (void)saleTicket
{
    
//    OSSpinLock lock = OS_SPINLOCK_INIT;
//    OSSpinLockLock(&lock); // 加锁
//    [super saleTicket];
//    OSSpinLockUnlock(&lock);
    // 结果有问题 lock是个局部变量，每次进来都创建新的锁，故达不到加锁的效果
    
    //----------------------------------------
    
    
    // 这样可以解决问题，大家访问的是同一把锁
    OSSpinLockLock(&_lock); // 加锁
    [super saleTicket];
    OSSpinLockUnlock(&_lock);
}




@end
