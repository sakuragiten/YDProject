//
//  RACDisposeController.m
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/3.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "RACDisposeController.h"
#import "RACDisposeNextController.h"

@interface RACDisposeController ()

@end

@implementation RACDisposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
}


- (void)setupView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(20, 100, 100, 40);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)clickAction {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@""];
    RACDisposeNextController *vc = [RACDisposeNextController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
