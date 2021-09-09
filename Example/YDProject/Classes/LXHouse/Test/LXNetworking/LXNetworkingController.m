//
//  LXNetworkingController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXNetworkingController.h"

@interface LXNetworkingController ()

@end

@implementation LXNetworkingController

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
    [btn setTitle:@"tap to start a request task" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(30, 100, 300, 60);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    NSString *url = @"http://10.1.220.5:9090/service-house/house/detailIndexById/2129048762218196994";
    
    NSLog(@"%@", url);
    [LXNetworking requestGetWithPath:url params:nil completionHandle:^(BOOL success, id responseObj, NSString *errorMsg) {
        NSLog(@"%@", responseObj);
    }];
}

@end
