//
//  YDLikeButton.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/22.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDLikeButton.h"
#define kWindow [UIApplication sharedApplication].keyWindow
@interface YDLikeButton ()

@property (nonatomic, strong) UIImage *before_image;

@property (nonatomic, strong) UIImage *after_image;

@property (nonatomic, strong) NSMutableArray *animationLayerArray;

@end

@implementation YDLikeButton


- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    if (state == UIControlStateNormal) {
        _before_image = image;
    } else if (state == UIControlStateSelected) {
        _after_image = image;
    }
    [super setImage:image forState:state];
    
}

- (void)startAnimation
{
    // cell 刷新的时候 会移除动画 所以需要放在window上
    UIView *superView = [UIView new];
    superView.frame = [self.superview convertRect:self.superview.bounds toView:kWindow];
    superView.backgroundColor = [UIColor clearColor];
    [kWindow addSubview:superView];
    
    
    CGSize size = self.after_image.size;
    CGPoint center = self.center;
    CGFloat circleWidth = size.width * 4.0 / 36.0;
    CGFloat scale = size.width / circleWidth;
    
    UIImageView *beforeImageView = [[UIImageView alloc] initWithImage:self.before_image];
    beforeImageView.frame = CGRectMake(0, 0, size.width, size.height);
    beforeImageView.center = center;
    [superView addSubview:beforeImageView];
    
    UIImageView *afterImageView = [[UIImageView alloc] initWithImage:self.after_image];
    afterImageView.frame = CGRectMake(0, 0, size.width, size.height);
    afterImageView.center = center;
    [superView addSubview:afterImageView];
    
    self.hidden = YES;
    
    
    UIView *white = [self whiteViewWithWidth:circleWidth];
    UIView *red = [self redViewWithWidth:circleWidth * 2];
    
    [superView insertSubview:white belowSubview:afterImageView];
    [superView insertSubview:red belowSubview:white];
    
    afterImageView.transform = CGAffineTransformMakeScale(0, 0);
    
    [self boomAnimationWithRadius:size.width * 0.7 superView:superView];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        beforeImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        white.hidden = NO;
        red.hidden = NO;
        
    }];
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.18 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{

        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.25 animations:^{
            afterImageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.15 animations:^{
            afterImageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.1 animations:^{
            afterImageView.transform = CGAffineTransformIdentity;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
            red.transform = CGAffineTransformMakeScale(scale * 0.49, scale * 0.49);
            white.transform = CGAffineTransformMakeScale(scale, scale);
        }];

    } completion:^(BOOL finished) {
        self.hidden = NO;
        [beforeImageView removeFromSuperview];
        [afterImageView removeFromSuperview];
        [white removeFromSuperview];
        [red removeFromSuperview];
        [superView removeFromSuperview];
        [self removeAnimationLayer];
    }];
}




- (UIView *)whiteViewWithWidth:(CGFloat)width
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, width, width);
    view.layer.cornerRadius = width * 0.5;
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.center = self.center;
    view.hidden = YES;
    return view;
}

- (UIView *)redViewWithWidth:(CGFloat)width
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, width, width);
    view.layer.cornerRadius = width * 0.5;
    view.layer.backgroundColor = [UIColor redColor].CGColor;
    view.center = self.center;
    view.hidden = YES;
    return view;
}


- (void)boomAnimationWithRadius:(CGFloat)radius superView:(UIView *)superView
{
    CGFloat duration = 0.8;
    CGFloat length = radius;
    CGFloat scale = radius / 20.0;
    CGPoint point = self.center;
    
    _animationLayerArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.position = point;
        layer.fillColor = [UIColor redColor].CGColor;

        UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-1, -length + 4 * scale, 2 * scale, 3 * scale)];
        layer.path = startPath.CGPath;

        layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0, 0, 1.0);
        [superView.layer addSublayer:layer];

        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.removedOnCompletion = NO;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.fillMode = kCAFillModeForwards;
        group.duration = duration;

        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = @(0.0f);
        scaleAnim.toValue = @(1.0f);
        scaleAnim.duration = duration * 0.3f;

        UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, -length, 1 * scale, 1 * scale)];

        CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnim.fromValue = (__bridge id)layer.path;
        pathAnim.toValue = (__bridge id)endPath.CGPath;
        pathAnim.beginTime = 0.4;
        pathAnim.duration = 0.4f;

        [group setAnimations:@[scaleAnim, pathAnim]];
        [layer addAnimation:group forKey:nil];
        [_animationLayerArray addObject:layer];
    }
}

- (void)removeAnimationLayer
{
    for (CALayer *layer in _animationLayerArray) {
        [layer removeFromSuperlayer];
    }
}



@end
