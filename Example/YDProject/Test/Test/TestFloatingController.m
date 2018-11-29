//
//  TestFloatingController.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/29.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import "TestFloatingController.h"

@interface TestFloatingController ()

@end

@implementation TestFloatingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor randomColor];
    
    [self initUI];
}

- (void)initUI
{
    [self addTestBtn];
}
- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor randomColor];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
//    [FloatingButton show];
    
    [FloatingButton showWithImageName:@"yao.jpg"];
}



@end
