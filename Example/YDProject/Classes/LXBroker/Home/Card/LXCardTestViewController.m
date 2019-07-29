//
//  LXCardTestViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXCardTestViewController.h"

#import "LXBrokerCardView.h"
#import "LXBroadcastView.h"

@interface LXCardTestViewController ()


@property (nonatomic, strong) LXBrokerCardView *cardView;


@end

@implementation LXCardTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    NSInteger a = (-3) / 2;
    NSLog(@"a = %ld", a);
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    _cardView = [LXBrokerCardView new];
    [self.view addSubview:_cardView];
    
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(203);
    }];
    
    
    LXBroadcastView *view = [LXBroadcastView new];
    view.dataArray = @[@{
                           @"title" : @"zhangsan",
                           @"content" : @"这是第一段恒昌恒昌很长很长很长圣诞节啊肯德基熬枯受淡文字",
                           @"subTitle" : @"收佣",
                           @"subContent" : @"11万"
                           }, @{
                           @"title" : @"lisi",
                           @"content" : @"这是第二段文字",
                           @"subTitle" : @"收佣",
                           @"subContent" : @"12万"
                           }, @{
                           @"title" : @"wangwu",
                           @"content" : @"这是第三文字",
                           @"subTitle" : @"收佣",
                           @"subContent" : @"13万"
                           }, @{
                           @"title" : @"zhaoliu",
                           @"content" : @"这是第四段文字",
                           @"subTitle" : @"收佣",
                           @"subContent" : @"14万"
                           },@{
                           @"title" : @"qianqi",
                           @"content" : @"这是第五段文字",
                           @"subTitle" : @"收佣",
                           @"subContent" : @"13242万"
                           },];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
    }];
//    view.backgroundColor = [UIColor randomColor];
    
}


@end
