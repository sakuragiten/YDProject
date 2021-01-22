//
//  PresentationTransition.m
//  JMPanKeTong
//
//  Created by louxunmac on 2019/11/5.
//  Copyright © 2019 Qfang.com. All rights reserved.
//

#import "PresentationTransition.h"
#import "PresentationAnimatedTransition.h"


@implementation PresentationTransition


- (instancetype)init
{
    if (self = [super init]) {
        self.interactiveTransition = [[InteractiveTransition alloc] initWithInteractiveMode:InteractiveModeDragDown transitionType:InteractiveTransitionTypeDismiss];
    }
    return self;
}







- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    PresentationAnimatedTransition *animationTransition = [[PresentationAnimatedTransition alloc] initWithTransitionStyle:TransitionStylePresentation];
    return animationTransition;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    PresentationAnimatedTransition *animationTransition = [[PresentationAnimatedTransition alloc] initWithTransitionStyle:TransitionStyleDismissal];
    return animationTransition;
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return  self.interactiveTransition.interactive ? self.interactiveTransition : nil;
}










@end
