//
//  YDVideoLikeButton.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/22.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDVideoLikeButton.h"

#define kWindow [UIApplication sharedApplication].keyWindow
@interface YDVideoLikeButton ()

@property (nonatomic, strong) UIImage *before_image;

@property (nonatomic, strong) UIImage *after_image;

@property (nonatomic, strong) NSMutableArray *animationLayerArray;

@end

@implementation YDVideoLikeButton


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
    CGFloat circleWidth = size.width * 3.0 / 36.0;
    CGFloat scale = size.width / circleWidth;
    
    
//
//    UIImageView *afterImageView = [[UIImageView alloc] initWithImage:self.after_image];
//    afterImageView.frame = CGRectMake(0, 0, size.width, size.height);
//    afterImageView.center = center;
//    [superView addSubview:afterImageView];
    
    self.hidden = YES;
    
    
    UIView *white = [self whiteViewWithWidth:circleWidth];
    UIView *red = [self redViewWithWidth:circleWidth * 2];
    
    [superView addSubview:red];
    [superView addSubview:white];
    
    
    UIImageView *left = [[UIImageView alloc] initWithImage:self.after_image];
    left.frame = CGRectMake(0, 0, size.width * 0.3, size.height * 0.3);
    left.center = center;
    left.alpha = 0.0;
    left.contentMode = UIViewContentModeScaleAspectFill;
    left.clipsToBounds = YES;
    [superView addSubview:left];
    
    UIImageView *right = [[UIImageView alloc] initWithImage:self.after_image];
    right.frame = CGRectMake(0, 0, size.width * 0.5, size.height * 0.5);
    right.center = center;
    right.alpha = 0.0;
    right.contentMode = UIViewContentModeScaleAspectFill;
    right.clipsToBounds = YES;
    [superView addSubview:right];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.after_image];
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    imageView.center = center;
    imageView.alpha = 0.0;
    [superView addSubview:imageView];
    imageView.transform = CGAffineTransformMakeScale(0.15, 0.15);
    
    
    
    
    
    [UIView animateKeyframesWithDuration:0.8 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{

        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            red.transform = CGAffineTransformMakeScale(7, 7);
            white.transform = CGAffineTransformMakeScale(3, 3);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.1 animations:^{
            red.transform = CGAffineTransformMakeScale(7, 7);
            white.transform = CGAffineTransformMakeScale(8, 8);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.1 animations:^{
            red.transform = CGAffineTransformMakeScale(7, 7);
            white.transform = CGAffineTransformMakeScale(13, 13);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.05 animations:^{
            red.alpha = 0.0;
            white.alpha = 0.0;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0.18 relativeDuration:0.02 animations:^{
            imageView.alpha = 1.0;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.1 animations:^{
            imageView.transform = CGAffineTransformIdentity;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.1 animations:^{
            imageView.transform = CGAffineTransformMakeRotation(M_PI / 4.0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.1 animations:^{
            imageView.transform = CGAffineTransformIdentity;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.46 relativeDuration:0.02 animations:^{
            left.alpha = 1.0;
            right.alpha = 1.0;
        }];
        
        
        [UIView addKeyframeWithRelativeStartTime:0.48 relativeDuration:0.22 animations:^{
            left.layer.transform = CATransform3DMakeTranslation(-5, -20, -10);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.05 animations:^{
            left.alpha = 0;
        }];
        

        [UIView addKeyframeWithRelativeStartTime:0.55 relativeDuration:0.25 animations:^{
            CATransform3D scaleAnimation = CATransform3DMakeScale(0.5, 0.5, 1);
            CATransform3D translateAnimation = CATransform3DMakeTranslation(5, -25, -15);
            right.layer.transform = CATransform3DConcat(scaleAnimation, translateAnimation);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.78 relativeDuration:0.02 animations:^{
            right.alpha = 0.5;
        }];
        
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [superView removeFromSuperview];
    }];
}






- (void)startAnimation2
{
    // cell 刷新的时候 会移除动画 所以需要放在window上
    UIView *superView = [UIView new];
    superView.frame = [self.superview convertRect:self.superview.bounds toView:kWindow];
    superView.backgroundColor = [UIColor clearColor];
    [kWindow addSubview:superView];
    
    
    CGSize size = self.after_image.size;
    CGPoint center = self.center;
    CGFloat circleWidth = size.width * 3.0 / 36.0;
    CGFloat scale = size.width / circleWidth;
    
    self.hidden = YES;
    
    
    UIView *white = [self whiteViewWithWidth:circleWidth];
    UIView *red = [self redViewWithWidth:circleWidth * 2];
    
    [superView addSubview:red];
    [superView addSubview:white];
    
    
//    afterImageView.transform = CGAffineTransformMakeScale(0, 0);
    
//    [self boomAnimationWithRadius:size.width * 0.7 superView:superView];
    
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{

        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            red.transform = CGAffineTransformScale(red.transform, 7, 7);
            white.transform = CGAffineTransformScale(white.transform, 2.5, 2.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.1 animations:^{
            red.transform = CGAffineTransformScale(red.transform, 1, 1);
            white.transform = CGAffineTransformScale(white.transform, 3, 3);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.1 animations:^{
            red.transform = CGAffineTransformScale(red.transform, 1, 1);
            white.transform = CGAffineTransformScale(white.transform, 1.7, 1.7);
        }];
        
        

    } completion:^(BOOL finished) {
        self.hidden = NO;
        [white removeFromSuperview];
        [red removeFromSuperview];
        [superView removeFromSuperview];
    }];
}





- (UIView *)whiteViewWithWidth:(CGFloat)width
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, width, width);
    view.layer.cornerRadius = width * 0.5;
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.center = self.center;
    return view;
}

- (UIView *)redViewWithWidth:(CGFloat)width
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, width, width);
    view.layer.cornerRadius = width * 0.5;
    view.layer.backgroundColor = [UIColor redColor].CGColor;
    view.center = self.center;
    return view;
}







@end
