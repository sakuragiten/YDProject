//
//  YDPresentDestinationViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDPresentDestinationViewController.h"
#import "PresentationTransition.h"

@interface YDPresentDestinationViewController ()
//<UIViewControllerTransitioningDelegate>

//@property (nonatomic, strong) PresentationTransition *transition;

@property (nonatomic, strong) PresentationTransition *transition;

@end

@implementation YDPresentDestinationViewController

- (instancetype)init
{
    if (self = [super init]) {
        _transition = [PresentationTransition new];
        [_transition.interactiveTransition addPanGestureForViewController:self];
        self.transitioningDelegate = _transition;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
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
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



@end
