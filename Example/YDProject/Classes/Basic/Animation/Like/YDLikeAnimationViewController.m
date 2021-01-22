//
//  YDLikeAnimationViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/20.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDLikeAnimationViewController.h"

@interface YDLikeAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIButton *likeBtn;


@property (nonatomic, strong) UIImageView *before_imageView;

@property (nonatomic, strong) UIImageView *after_imageView;

@property (nonatomic, strong) NSMutableArray *animationLayerArray;

@end

@implementation YDLikeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setImage:[[UIImage imageNamed:@"icon_dynamic_like_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_likeBtn setImage:[[UIImage imageNamed:@"icon_dynamic_like_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _likeBtn.frame = CGRectMake(0, 0, 100, 100);
    _likeBtn.center = self.view.center;
    
    [self.view addSubview:self.likeBtn];
    
    
    UIImage *before_image = [UIImage imageNamed:@"icon_dynamic_like_normal"];
    _before_imageView = [UIImageView new];
    _before_imageView.image = before_image;
    _before_imageView.frame = CGRectMake(0, 0, before_image.size.width, before_image.size.height);
    _before_imageView.center = self.likeBtn.center;
    
    UIImage *after_image = [UIImage imageNamed:@"icon_dynamic_like_selected"];
    _after_imageView = [UIImageView new];
    _after_imageView.image = after_image;
    _after_imageView.frame = CGRectMake(0, 0, after_image.size.width, after_image.size.height);
    _after_imageView.center = self.likeBtn.center;
    
    [self.view addSubview:_before_imageView];
    [self.view addSubview:_after_imageView];
    
    _before_imageView.hidden = YES;
    _after_imageView.hidden = YES;
    
}

- (void)likeAction:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    
    if (btn.isSelected) {
        [self likeAnimation2];
    }
    
}


- (void)likeAnimation3
{
    self.likeBtn.hidden = YES;

    UIView *white = [self whiteView];
    UIView *red = [self redView];
    [self.view insertSubview:white belowSubview:self.after_imageView];
    [self.view insertSubview:red belowSubview:white];
    
    self.before_imageView.hidden = NO;
    self.after_imageView.hidden = NO;
    self.after_imageView.transform = CGAffineTransformMakeScale(0, 0);
    
    
    [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{

        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.before_imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.25 animations:^{
            self.after_imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.15 animations:^{
            self.after_imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.1 animations:^{
            self.after_imageView.transform = CGAffineTransformIdentity;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.3 animations:^{
            red.hidden = NO;
            white.hidden = NO;
            red.transform = CGAffineTransformMakeScale(4.4, 4.4);
            white.transform = CGAffineTransformMakeScale(9, 9);
        }];

    } completion:^(BOOL finished) {
        self.likeBtn.hidden = NO;
        self.after_imageView.hidden = YES;
        self.before_imageView.hidden = YES;
        self.before_imageView.transform = CGAffineTransformIdentity;
        [white removeFromSuperview];
        [red removeFromSuperview];
    }];
    
}



- (void)likeAnimation2
{
    self.likeBtn.hidden = YES;

    UIView *white = [self whiteView];
    UIView *red = [self redView];
    [self.view insertSubview:white belowSubview:self.after_imageView];
    [self.view insertSubview:red belowSubview:white];
    
    self.before_imageView.hidden = NO;
    self.after_imageView.hidden = NO;
    self.after_imageView.transform = CGAffineTransformMakeScale(0, 0);
    
    
    [self boomAnimation];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.before_imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        white.hidden = NO;
        red.hidden = NO;
        
    }];
    
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.18 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{

        
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.25 animations:^{
            self.after_imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.15 animations:^{
            self.after_imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.1 animations:^{
            self.after_imageView.transform = CGAffineTransformIdentity;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
            red.transform = CGAffineTransformMakeScale(4.4, 4.4);
            white.transform = CGAffineTransformMakeScale(9, 9);
        }];

    } completion:^(BOOL finished) {
        self.likeBtn.hidden = NO;
        self.after_imageView.hidden = YES;
        self.before_imageView.hidden = YES;
        self.before_imageView.transform = CGAffineTransformIdentity;
        [white removeFromSuperview];
        [red removeFromSuperview];
        [self removeAnimationLayer];
    }];
    
}


- (void)likeAnimation
{
    self.likeBtn.hidden = YES;
    
    CGSize size = self.after_imageView.image.size;
    
    UIView *view = [self circleViewWithSize:size];
    [self.view addSubview:view];
    view.center = self.likeBtn.center;
    view.hidden = NO;
    
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        self.likeBtn.hidden = NO;
    }];
    
    return;
    
    self.before_imageView.hidden = NO;
    self.after_imageView.hidden = NO;
    self.after_imageView.transform = CGAffineTransformMakeScale(0, 0);
    
    
    
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.before_imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//    } completion:^(BOOL finished) {
//        self.before_imageView.hidden = YES;
//        self.before_imageView.transform = CGAffineTransformIdentity;
//        circleLayer.hidden = NO;
//        self.after_imageView.hidden = NO;
//    }];
    
    [UIView animateKeyframesWithDuration:0.8 delay:0.2 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
    
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.before_imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.25 animations:^{
            self.after_imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.15 animations:^{
            self.after_imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.1 animations:^{
            self.after_imageView.transform = CGAffineTransformIdentity;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.3 animations:^{

        }];

    } completion:^(BOOL finished) {
        self.likeBtn.hidden = NO;
        self.after_imageView.hidden = YES;
        self.before_imageView.hidden = YES;
        [self removeAnimationLayer];
    }];
}


- (UIView *)circleViewWithSize:(CGSize)size
{
    UIView *view = [UIView new];
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.cornerRadius = size.width * 0.2;
    view.layer.borderWidth = 3.0;
    view.frame = CGRectMake(0, 0, size.width, size.width);
    
    return view;
}


- (UIView *)whiteView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 4, 4);
    view.layer.cornerRadius = 2.0;
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.center = self.likeBtn.center;
    view.hidden = YES;
    return view;
}

- (UIView *)redView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 8, 8);
    view.layer.cornerRadius = 4.0;
    view.layer.backgroundColor = [UIColor redColor].CGColor;
    view.center = self.likeBtn.center;
    view.hidden = YES;
    return view;
}


- (void)boomAnimation
{
    CGFloat duration = 0.8;
    CGFloat length = 20.0;
    CGPoint point = self.likeBtn.center;
    _animationLayerArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.position = point;
        layer.fillColor = [UIColor redColor].CGColor;

//        UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-1, -length + 8, 2, 2)];
        UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-1, -length + 4, 2, 3)];
        layer.path = startPath.CGPath;

        layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0, 0, 1.0);
        [self.view.layer addSublayer:layer];

        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.removedOnCompletion = NO;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.fillMode = kCAFillModeForwards;
        group.duration = duration;

        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = @(0.0f);
        scaleAnim.toValue = @(1.0f);
        scaleAnim.duration = duration * 0.3f;

//        UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-1, -length, 1, 1)];
        UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, -length, 1, 1)];

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



- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
