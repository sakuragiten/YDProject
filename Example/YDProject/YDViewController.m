//
//  YDViewController.m
//  YDProject
//
//  Created by 387970107@qq.com on 04/18/2018.
//  Copyright (c) 2018 387970107@qq.com. All rights reserved.
//

#import "YDViewController.h"
#import <YDProject/YDPoject.h>
@interface YDViewController ()

@end

@implementation YDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    YDMap *map = [YDMap new];
    [map setObject:@"Viktor Kong" forkey:@"test"];
    map[@"key"] = @"Edison";
    map[@"key"] = @"Einstein";
    NSLog(@"%@", map[0]);
    NSLog(@"%ld", map.allKeys.count);
    NSLog(@"%@", map.allKeys.lastObject);
    NSLog(@"%@", map.allValues.lastObject);
    NSLog(@"%@", map.allValues.lastObject);

    map[@"key"] = nil;
}

@end
