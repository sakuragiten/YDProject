//
//  PushAnimatedTransition.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/6/3.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "PushAnimatedTransition.h"


@interface PushAnimatedTransition ()

@property(nonatomic, assign) PushAnimationStyle transitionStyle;

@end


@implementation PushAnimatedTransition

- (instancetype)initWithTransitionStyle:(PushAnimationStyle)transitionStyle
{
    if (self = [super init]) {
        _transitionStyle = transitionStyle;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _transitionStyle == PushAnimationStylePush ? 0.5 : 0.25;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
    switch (_transitionStyle) {
        case PushAnimationStylePush:
            [self pushAnimation:transitionContext];
            break;
            
        case PushAnimationStylePop:
            [self popAnimation:transitionContext];
            break;
    }
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //拿到当前点击的cell的imageView
    UIView *view = [fromVC.view viewWithTag:1988];
    UIView *containerView = [transitionContext containerView];
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [view convertRect:view.bounds toView: containerView];
    //设置动画前的各个控件的状态
    view.hidden = YES;
    toVC.view.alpha = 0;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [UIScreen mainScreen].bounds;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *view = [toVC.view viewWithTag:1988];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    view.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [view convertRect:view.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

@end
