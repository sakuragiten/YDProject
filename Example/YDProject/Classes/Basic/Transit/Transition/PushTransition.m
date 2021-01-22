//
//  PushTransition.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "PushTransition.h"
#import "PresentationAnimatedTransition.h"

@implementation PushTransition


- (instancetype)init
{
    if (self = [super init]) {
        self.interactiveTransition = [[InteractiveTransition alloc] initWithInteractiveMode:InteractiveModeDragDown transitionType:InteractiveTransitionTypeDismiss];
    }
    return self;
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    PresentationAnimatedTransition *animationTransition = [[PresentationAnimatedTransition alloc] initWithTransitionStyle:operation == UINavigationControllerOperationPush ? TransitionStylePresentation : TransitionStyleDismissal];
    return animationTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //手势开始的时候才需要传入手势过渡代理，如果直接点击pop，应该传入空，否者无法通过点击正常pop
    return  self.interactiveTransition.interactive ? self.interactiveTransition : nil;
}

@end
