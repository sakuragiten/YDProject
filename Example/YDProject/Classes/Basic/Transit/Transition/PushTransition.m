//
//  PushTransition.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "PushTransition.h"
#import "PushAnimatedTransition.h"

@implementation PushTransition


- (instancetype)init
{
    if (self = [super init]) {
        self.interactiveTransition = [[InteractiveTransition alloc] initWithInteractiveMode:InteractiveModeDragDown transitionType:InteractiveTransitionTypePop];
    }
    return self;
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    PushAnimationStyle style = operation == UINavigationControllerOperationPush ? PushAnimationStylePush : PushAnimationStylePop;
    
    return [[PushAnimatedTransition alloc] initWithTransitionStyle:style];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return self.interactiveTransition.interactive ? self.interactiveTransition : nil;
}



@end
