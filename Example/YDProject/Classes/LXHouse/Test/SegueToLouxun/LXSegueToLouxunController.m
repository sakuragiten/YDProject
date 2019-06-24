//
//  LXSegueToLouxunController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/28.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXSegueToLouxunController.h"

@interface LXSegueToLouxunController ()

@end

@implementation LXSegueToLouxunController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}



- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addTestBtn];
    
}


- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"tap to segue to louxun app" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(40, 100, 240, 50);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    NSURL *url = [NSURL URLWithString:@"louxun://"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url];
    } else {
        NSLog(@"can not open");
    }
   
}

@end
