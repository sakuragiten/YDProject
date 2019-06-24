//
//  LXCardTestViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXCardTestViewController.h"

#import "LXBrokerCardView.h"

@interface LXCardTestViewController ()


@property (nonatomic, strong) LXBrokerCardView *cardView;


@end

@implementation LXCardTestViewController

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
    
    
    _cardView = [LXBrokerCardView new];
    [self.view addSubview:_cardView];
    
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(140);
    }];
    
}


@end
