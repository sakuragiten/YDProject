//
//  TestLockViewController.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/12/22.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "TestLockViewController.h"

#import "OSSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "MutexLockDemo.h"

@interface TestLockViewController ()
@end

@implementation TestLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    BaseLockDemo *demo = [MutexLockDemo new];
    [demo ticketTest];
//    [demo moneyTest];
}



@end

