//
//  UIView+Animation.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/27.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "UIView+Animation.h"

#define kWindow [UIApplication sharedApplication].keyWindow

@implementation UIView (Animation)


- (void)showAnimationAtLocation:(CGPoint)location
{
    UIImage *image = [UIImage imageNamed:@"icon_dynamic_like_selected"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGSize size = image.size;
    imageView.frame = CGRectMake(0, 0, size.width * 1.5, size.height * 1.5);
    imageView.center = CGPointMake(location.x, location.y -  size.height * 0.75);
    [self addSubview:imageView];
    
    CAKeyframeAnimation *rotaiton =[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotaiton.values = @[@(0), @(M_PI * 0.3), @(-M_PI * 0.3), @(0)];
    rotaiton.duration = 0.5;
    
    [imageView.layer addAnimation:rotaiton forKey:@"rotation"];
    
    
    CAEmitterCell *cell = [self emitterCell];
    CAEmitterLayer *emitterLayer = [CAEmitterLayer new];
    emitterLayer.name = @"explosionLayer";
    emitterLayer.emitterShape = kCAEmitterLayerOutline;//设置形状
    emitterLayer.emitterMode = kCAEmitterLayerOutline;//设置模式,从哪个位置发出，从发射器边缘发射
    emitterLayer.renderMode = kCAEmitterLayerAdditive;//渲染模式，越早的在上面
    emitterLayer.emitterSize = CGSizeMake(1, 1);//设置大小
    emitterLayer.emitterCells = @[cell];//可以设置多种cell
    emitterLayer.birthRate = 2;//整个例子的数量
    emitterLayer.position = imageView.center;
    [self.layer addSublayer:emitterLayer];
    
    [self performSelector:@selector(removeImageViewAnimation:) withObject:imageView afterDelay:0.5];
    [self performSelector:@selector(stopEnitter:) withObject:emitterLayer afterDelay:0.2];
    [self performSelector:@selector(removeLayerAnimation:) withObject:emitterLayer afterDelay:2];
    
}

- (void)removeImageViewAnimation:(UIImageView *)imageView
{
    [imageView.layer removeAllAnimations];
    [UIView animateWithDuration:0.8 animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)stopEnitter:(CAEmitterLayer *)emitterLayer
{
    emitterLayer.birthRate = 0;
}

- (void)removeLayerAnimation:(CAEmitterLayer *)emitterLayer
{
    [emitterLayer removeFromSuperlayer];
}


- (CAEmitterCell *)emitterCell
{
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    
    cell.name = @"heartCell";
    
    cell.birthRate = 2;
    cell.emissionRange = 0.12 * M_PI;
    cell.emissionLongitude = -M_PI * 0.5;
    cell.velocity = 300;
    cell.velocityRange = 150;
    cell.yAcceleration = 0;
    cell.lifetime = 2.0;
    
    cell.contents = (id)[UIImage imageNamed:@"icon_dynamic_like_selected"].CGImage;
    cell.scale = 0.3;
    cell.scaleRange = 0.2;
    cell.alphaSpeed = -1;
    cell.alphaRange = 0.2;
    cell.spinRange = M_PI;
    
    return cell;
}



- (CALayer *)layerWithImageName:(NSString *)imageName
{
    if (imageName.length == 0) return nil;
    UIImage *image = [UIImage imageNamed:imageName];
    CALayer *layer = [CALayer layer];
    [layer setContents:(id)image.CGImage];
    
    layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    return layer;
}



@end
