//
//  YDPushDestinationViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDPushDestinationViewController.h"
#import "PushTransition.h"

@interface YDPushDestinationViewController ()

@property (nonatomic, strong) PushTransition *transition;

@end

@implementation YDPushDestinationViewController

- (instancetype)init
{
    if (self = [super init]) {
        _transition = [PushTransition new];
        [_transition.interactiveTransition addPanGestureForViewController:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.navigationController.delegate = self.transition;
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor randomColor];
    [self.view addSubview:btn];
}

- (void)tapAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
