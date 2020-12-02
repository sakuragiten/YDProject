//
//  TestAlbumViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/5/28.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "TestAlbumViewController.h"
#import "AlbumViewController.h"

@interface TestAlbumViewController ()

@end

@implementation TestAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}


- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    AlbumViewController *vc = [AlbumViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
