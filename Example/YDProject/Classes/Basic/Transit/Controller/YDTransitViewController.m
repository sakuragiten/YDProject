//
//  YDTransitViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDTransitViewController.h"
#import "YDPresentDestinationViewController.h"
#import "YDPushDestinationViewController.h"
#import "PushTransition.h"
#import "YDPresentNavViewController.h"
#import "YDPresentNavDestinationViewController.h"

@interface YDTransitViewController ()

@property (nonatomic, strong) PushTransition *transition;

@end

@implementation YDTransitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"present" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(tapAction1) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 100, 100, 50);
        btn.backgroundColor = [UIColor randomColor];
        [self.view addSubview:btn];
    }
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"push" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(tapAction2) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 300, 100, 50);
        btn.backgroundColor = [UIColor randomColor];
        [self.view addSubview:btn];
        btn.tag = 1988;
    }
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"present nav" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(tapAction3) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(100, 400, 100, 50);
        btn.backgroundColor = [UIColor randomColor];
        [self.view addSubview:btn];
    }
    
    _transition = [PushTransition new];
    [_transition.interactiveTransition addPanGestureForViewController:self];
    self.navigationController.delegate = self.transition;
}

- (void)tapAction1
{
    YDPresentDestinationViewController *vc = [YDPresentDestinationViewController new];
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)tapAction2
{
    YDPushDestinationViewController *vc = [YDPushDestinationViewController new];
    self.navigationController.delegate = vc.transition;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)tapAction3
{
    YDPresentNavDestinationViewController *vc = [YDPresentNavDestinationViewController new];
    YDPresentNavViewController *nav = [[YDPresentNavViewController alloc] initWithRootViewController:vc];
//    YDPresentNavViewController *nav = [YDPresentNavViewController new];
    [self presentViewController:nav animated:YES completion:nil];

}


@end
