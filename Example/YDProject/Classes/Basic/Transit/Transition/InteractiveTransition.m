//
//  InteractiveTransition.m
//  JMPanKeTong
//
//  Created by louxunmac on 2019/11/5.
//  Copyright © 2019 Qfang.com. All rights reserved.
//

#import "InteractiveTransition.h"

@interface InteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;

@end

@implementation InteractiveTransition



- (instancetype)initWithInteractiveMode:(InteractiveMode)interactiveMode transitionType:(InteractiveTransitionType)type
{
    if (self = [super init]) {
        self.interactiveMode = interactiveMode;
        self.type = type;
    }
    return self;
}


- (void)addPanGestureForViewController:(UIViewController *)viewController
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [viewController.view addGestureRecognizer:pan];
    _vc = viewController;
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_interactiveMode) {
        case InteractiveModeNone: {
            break;
        }
        case InteractiveModeSideslip:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveModeDragDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interactive = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interactive = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case InteractiveTransitionTypeDismiss:{
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}


@end
