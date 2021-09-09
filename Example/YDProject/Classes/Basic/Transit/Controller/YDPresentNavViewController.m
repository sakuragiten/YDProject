//
//  YDPresentNavViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDPresentNavViewController.h"
#import "PresentationTransition.h"


@interface YDPresentNavViewController ()

@property (nonatomic, strong) PresentationTransition *transition;

@end

@implementation YDPresentNavViewController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        _transition = [PresentationTransition new];
        [_transition.interactiveTransition addPanGestureForViewController:self];
        self.transitioningDelegate = _transition;
        self.modalPresentationStyle = UIModalPresentationCustom;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
