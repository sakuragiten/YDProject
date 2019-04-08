//
//  BlockViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/2/20.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "BlockViewController.h"
#import "YDBlock.h"

/**
 * 什么是block
 * block是将函数及其执行上下文封装的对象
 * block的调用就是函数的调用
 */

/**
 * 源码解析
 * 使用 [clang -rewrite-objc file.m]
 */


@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    YDBlock *b = [YDBlock new];
    [b test];
    
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
