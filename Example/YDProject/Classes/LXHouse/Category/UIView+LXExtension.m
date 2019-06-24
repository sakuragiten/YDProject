//
//  UIView+LXExtension.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/15.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "UIView+LXExtension.h"

@implementation UIView (LXExtension)

- (void)lx_settingGradientLayer
{
    UIColor *fromColor = [UIColor colorWithHexString:@"#00A9FF"];
    UIColor *toColor = [UIColor colorWithHexString:@"#0072E7"];
    
    [self lx_settingGradientLayerFromColor:fromColor toColor:toColor];
}

- (void)lx_settingGradientLayer:(void (^)(CAGradientLayer * _Nonnull))configuration
{
    UIColor *fromColor = [UIColor colorWithHexString:@"#00A9FF"];
    UIColor *toColor = [UIColor colorWithHexString:@"#0072E7"];
    [self lx_settingGradientLayerFromColor:fromColor toColor:toColor config:configuration];
}


- (void)lx_settingGradientLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor
{
    [self lx_settingGradientLayerFromColor:fromColor toColor:toColor config:nil];
}

- (void)lx_settingGradientLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor config:(void(^)(CAGradientLayer *))configuration
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds = self.bounds;
    layer.anchorPoint = CGPointZero;
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    layer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    layer.locations = @[@(0), @(1.0f)];
    
    [self lx_settingGradientLayer:layer config:configuration];
}


- (void)lx_settingGradientLayer:(CAGradientLayer *)layer config:(void(^)(CAGradientLayer *))configuration
{
    !configuration ? : configuration(layer);
    
    if (self.superview) {
        [self lx_settingGradientLayer:layer inSuperView:self.superview];
    } else {
        @weakify(self)
        [[self rac_signalForSelector:@selector(willMoveToSuperview:)] subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            UIView *newSuperview = tuple.first;
            [self lx_settingGradientLayer:layer inSuperView:newSuperview];
        }];
    }
}


- (void)lx_settingGradientLayer:(CAGradientLayer *)layer inSuperView:(UIView *)newSuperview
{
    UIView *gradientView = [UIView new];
    gradientView.frame = self.frame;
    [newSuperview insertSubview:gradientView belowSubview:self];
    [gradientView.layer addSublayer:layer];
    
    @weakify(self)
    [[self rac_signalForSelector:@selector(layoutSubviews)] subscribeNext:^(id x) {
        @strongify(self)
        CGRect frame = self.frame;
        layer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        gradientView.frame = frame;
    }];
    
    RAC(gradientView, hidden) = [self rac_valuesForKeyPath:@"hidden" observer:nil];
    
}






@end


@implementation UIButton (LXExtension)

- (void)lx_reloadContentWithStyle:(LXButtonCoententStyle)style
{
    [self lx_reloadContentWithStyle:style contentSpace:6.0];
}


- (void)lx_reloadContentWithStyle:(LXButtonCoententStyle)style contentSpace:(CGFloat)space
{
    @weakify(self)
    [[self rac_signalForSelector:@selector(layoutSubviews)] subscribeNext:^(id x) {
        @strongify(self)
        [self lx_reloadContentAfterLayoutWithStyle:style contentSpace:space];
    }];
    
}

- (void)lx_reloadContentAfterLayoutWithStyle:(LXButtonCoententStyle)style contentSpace:(CGFloat)space
{
    if (!self.currentImage || self.frame.size.height == 0 || self.frame.size.width == 0) return;
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    UIEdgeInsets imageInset = UIEdgeInsetsZero;
    UIEdgeInsets titleInset = UIEdgeInsetsZero;
    CGFloat s = space * 0.5;
    if (style == LXButtonCoententImageTop) {
        imageInset = UIEdgeInsetsMake(-titleSize.height - s, 0, 0, -titleSize.width);
        titleInset = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height - s, 0);
    } else if (style == LXButtonCoententImageRight) {
        imageInset = UIEdgeInsetsMake(0, titleSize.width + s, 0, -titleSize.width - s);
        titleInset = UIEdgeInsetsMake(0, -imageSize.width - s, 0, imageSize.width + s);
    } else if (style == LXButtonCoententImageBottom) {
        imageInset = UIEdgeInsetsMake(0, 0, -titleSize.height - s, -titleSize.width);
        titleInset = UIEdgeInsetsMake(-imageSize.height - s, -imageSize.width, 0, 0);
    } else {
        imageInset = UIEdgeInsetsMake(0, -s, 0, s);
        titleInset = UIEdgeInsetsMake(0, s, 0, -s);
    }
    
    self.titleEdgeInsets = titleInset;
    self.imageEdgeInsets = imageInset;
    
}






@end
