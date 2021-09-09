//
//  LXPopLabel.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXPopLabel.h"

@interface LXPopLabel ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) CAShapeLayer *popLayer;


@end

@implementation LXPopLabel



- (instancetype)init
{
    if (self = [super init]) {
        [self initialPopLabel];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialPopLabel];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialPopLabel];
    }
    return self;
}


- (void)initialPopLabel
{
    _strokeColor = [UIColor colorWithHexString:@"#BCBFC5"];
    _lineWidth = 1.0;
    
    _textColor = [UIColor colorWithHexString:@"#BCBFC5"];
    
    _textAlignment = NSTextAlignmentCenter;
    _font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    
    _triangleSize = CGSizeMake(10, 6.5);
    
    
    _contentInsets = UIEdgeInsetsMake(3, 6, 3, 6);
    _maxWidth = 150.0;
    
    [self setupUI];
    
}


- (void)setupUI
{
    [self.layer addSublayer:self.popLayer];
    
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
}








- (void)layoutSubviews
{
    [self reloadSubView];
}


- (void)reloadSubView
{
    [self drawText];
    
    [self drawPop];
}

- (void)drawText
{
    _label.text = _text;
    _label.font = _font;
    _label.textAlignment = _textAlignment;
    _label.textColor = _textColor;
    
//    _label.backgroundColor = [UIColor cyanColor];
    
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName : _font}];
    CGFloat width = size.width > _maxWidth ? _maxWidth : size.width;
    width = width + self.contentInsets.left + self.contentInsets.right;
    CGFloat height = size.height + self.contentInsets.top + self.contentInsets.bottom;
    
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.mas_equalTo(0).priority(750);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(-0.25 * height).priority(750);
    }];
    
}


- (void)drawPop
{
    
    self.popLayer.bounds = self.bounds;
    self.popLayer.position = CGPointZero;
    self.popLayer.anchorPoint = CGPointZero;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat content_height = height * 0.8;
    
    CGPoint start = CGPointMake(width * 0.5, height);

    CGFloat trianleHeight = height - content_height;
    CGFloat trianleWidth = trianleHeight * 1.7;


    UIBezierPath *path = [UIBezierPath bezierPath];

    //anticlockwise
    [path moveToPoint:start];
    [path addLineToPoint:CGPointMake(start.x + trianleWidth * 0.5, content_height)];
    [path addLineToPoint:CGPointMake(width - content_height * 0.5, content_height)];
    [path addArcWithCenter:CGPointMake(width - content_height * 0.5, content_height * 0.5) radius:content_height * 0.5 startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:NO];
    

    [path addLineToPoint:CGPointMake(content_height * 0.5, 0)];
    [path addArcWithCenter:CGPointMake(content_height * 0.5, content_height * 0.5) radius:content_height * 0.5 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:NO];
    [path addLineToPoint:CGPointMake(start.x - trianleWidth * 0.5, content_height)];
    [path closePath];
    
    [_popLayer setFillColor:[UIColor clearColor].CGColor];
    [_popLayer setStrokeColor:_strokeColor.CGColor];
    _popLayer.lineWidth = _lineWidth;
    
    self.popLayer.path = path.CGPath;
    
}





- (CAShapeLayer *)popLayer
{
    if (!_popLayer) {
        _popLayer = [CAShapeLayer layer];
    }
    return _popLayer;
}



@end
