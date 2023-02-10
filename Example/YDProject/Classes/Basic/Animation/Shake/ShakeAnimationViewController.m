//
//  ShakeAnimationViewController.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2022/5/7.
//  Copyright © 2022 387970107@qq.com. All rights reserved.
//

#import "ShakeAnimationViewController.h"
#import "BehaviorView.h"

@interface ShakeAnimationViewController ()

@property (nonatomic, strong) BehaviorView *behaviorView;

@end

@implementation ShakeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    _behaviorView = [BehaviorView new];
    _behaviorView.score = 120;
    
    [self.view addSubview:_behaviorView];
    _behaviorView.frame = CGRectMake(100, 200, 86, 40);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.behaviorView startAnimation];
}


@end
