//
//  YDShapLayerController.m
//  YDProject_Example
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "YDShapLayerController.h"

@interface YDShapLayerController ()

@property(nonatomic, strong) CAShapeLayer *shapLayer;

@end

@implementation YDShapLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.titleLabel.font = UIFontMediumMake(14);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor randomColor];
    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(200, 100, 80, 40);
    [self shapTest:10];
}


- (void)shapTest:(CGFloat)r
{
//    for_test
    CGSize size = CGSizeMake(100, 100);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"for_test"]];
    imageView.frame = CGRectMake(100, 200, 100, 100);
    [self.view addSubview:imageView];
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 200, 200) cornerRadius:8];
    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(r, 0)];
    [path moveToPoint:CGPointMake(size.width * 0.5, 0)];
    [path addLineToPoint:CGPointMake(r, 0)];
    [path addArcWithCenter:CGPointMake(r, r) radius:r startAngle:M_PI_2 * 3 endAngle:M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(0, size.height - r)];
    [path addArcWithCenter:CGPointMake(r, size.height - r) radius:r startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    [path addLineToPoint:CGPointMake(size.width - r, size.height)];
    [path addArcWithCenter:CGPointMake(size.width - r, size.height - r) radius:r startAngle:M_PI_2 endAngle:0 clockwise:NO];
    [path addLineToPoint:CGPointMake(size.width, r)];
    [path addArcWithCenter:CGPointMake(size.width - r, r) radius:r startAngle:0 endAngle:M_PI_2 * 3 clockwise:NO];
    
    
    [path closePath];
    
    
    
    
    layer.strokeColor = [UIColor randomColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 5.0;
    layer.path = path.CGPath;
    layer.anchorPoint = CGPointZero;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 200);
    
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
//    layer.strokeEnd = 0.5;

    
    [self.view.layer addSublayer:layer];
    
    self.shapLayer = layer;
    
}



- (void)tapAction
{
    
    static CGFloat progress = 0.0;
    if (progress > 1) {
        progress = 0.0;
    }
    self.shapLayer.strokeEnd = progress;
    progress = progress + 0.02;
}
@end
