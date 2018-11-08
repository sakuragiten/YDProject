//
//  TestNetWorkController.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/8.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import "TestNetWorkController.h"
#import <YDProject/YDPoject.h>

@interface TestNetWorkController ()

@end

@implementation TestNetWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
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
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    NSString *url = @"https://testapi.mediportal.com.cn/online-marketing/mobil/promotion/getPromotionDetail/5be23e9c04dd3c07e8daa39a?access_token=9d7692dba4ad4029953ee2a14be26708 ";
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [YDNetwork sendGETReuqestWithUrl:url paramteres:nil completionHandle:^(BOOL success, id  _Nonnull responseObject, NSError * _Nonnull error) {
        NSLog(@"%@", responseObject);
    }];
}



@end
