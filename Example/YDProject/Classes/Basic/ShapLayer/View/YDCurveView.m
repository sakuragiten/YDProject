//
//  YDCurveView.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/12/7.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "YDCurveView.h"
#import "UIBezierPath+curved.h"



@interface YDCurveView ()
{
    CAShapeLayer *anmitionLayer;
    CAShapeLayer *grayLayer;
    CAShapeLayer *_bottomLayer;
}
@end

#define  VIEW_WIDTH  self.frame.size.width //底图的宽度
#define  VIEW_HEIGHT self.frame.size.height//底图的高度

#define  LABLE_WIDTH  VIEW_WIDTH //表的宽度
#define  LABLE_HEIGHT VIEW_HEIGHT //表的高度

@implementation YDCurveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 承载曲线图的View
        [self makeBottomlayer];
        
    }
    return self;
}



-(void)makeBottomlayer{

    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.backgroundColor = [UIColor clearColor].CGColor;
    _bottomLayer.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.layer addSublayer:_bottomLayer];
}

//画图
-(void)drawSmoothViewWithArrayX:(NSArray*)pathX andArrayY:(NSArray*)pathY andScaleX:(float)X{

    
    // 灰色路径
    [grayLayer removeFromSuperlayer];
    grayLayer = [self lineLayer];
    grayLayer.strokeColor = [UIColor colorWithHexString:@"#C4C4C4" ].CGColor;
    [self.layer addSublayer:grayLayer];
    
    [_bottomLayer removeFromSuperlayer];
    [self makeBottomlayer];
    
    
    // 创建layer并设置属性
    CAShapeLayer *layer = [self lineLayer];
    _bottomLayer.mask = layer;
    
    
    
    // 渐变色layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    gradientLayer.colors = @[
                             (__bridge id)[UIColor colorWithHexString:@"#0FCCDF"].CGColor,
                             (__bridge id)[UIColor colorWithHexString:@"#8FC31F"].CGColor,];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [_bottomLayer addSublayer:gradientLayer];

    
    
    
    CGPoint point;
    UIBezierPath *path = [UIBezierPath bezierPath];

    
//    CGFloat BLX = kScreenWidth / 375.0;
//    CGFloat BLY = 1.0 * BLX;
//
//    for (int i= 0; i< pathY.count; i++) {
//
//        CGFloat X = [pathX[i] floatValue] * BLX + (VIEW_WIDTH - LABLE_WIDTH) + 10;
//        CGFloat Y = LABLE_HEIGHT - [pathY[i] floatValue]*BLY + (VIEW_HEIGHT - LABLE_HEIGHT) / 2.0;
//        point = CGPointMake(X, Y);
//
//        //起点
//        if (i == 0) {
//            [path moveToPoint:point];
//        } else {
//            [path addLineToPoint:point];
//        }
//    }

    for (int i= 0; i< pathY.count; i++) {
        
        CGFloat X = [pathX[i] floatValue];
        CGFloat Y = [pathY[i] floatValue];
        point = CGPointMake(X, Y);
        
        //起点
        if (i == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }
    //平滑曲线
    path = [path smoothedPathWithGranularity:20];
    // 关联layer和贝塞尔路径~
    layer.path = path.CGPath;
    grayLayer.path = path.CGPath;
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [layer addAnimation:animation forKey:nil];
    
    layer.strokeEnd = 1;
    anmitionLayer = layer;
}



- (CAShapeLayer *)lineLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  2.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    return layer;
}



-(void)refreshChartAnmition{
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(3.0);
    animation.autoreverses = NO;
    animation.duration = 6.0;
    
    // 设置layer的animation
    [anmitionLayer addAnimation:animation forKey:nil];
    
    anmitionLayer.strokeEnd = 1;
    
}

@end
