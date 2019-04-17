//
//  YDFPS.m
//  YDProject
//
//  Created by louxunmac on 2019/4/17.
//

#import "YDFPS.h"


@interface FPSLabel : UILabel @end



@interface YDFPS ()

@property(nonatomic, strong) FPSLabel *valueLabel;

@property(nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CFTimeInterval lastTimestamp;

@property (nonatomic, assign) NSInteger performTimes;


@end

@implementation YDFPS



- (instancetype)init
{
    if (self = [super init]) {
        [self configuration];
    }
    
    return self;
}

- (void)configuration
{
    _smoothlyColor = [UIColor greenColor];
    _normalColor = [UIColor colorWithRed:250 green:205 blue:59 alpha:1];
    _worseColor = [UIColor redColor];
    
    _valueLabel = [FPSLabel new];
    _hidden = YES;
    
    
}


- (void)refreshWithFPSValue:(double)value
{
    value = round(value);
    
    _value = value;
    
    NSString *valueString = [NSString stringWithFormat:@"%.f", value];
    
    _valueLabel.text = [NSString stringWithFormat:@"FPS: %@", valueString];
    
    UIColor *textColor;
    if (_value < 70) {
        textColor = _smoothlyColor;
    } else if (_value < 100) {
        textColor = _normalColor;
    } else {
        textColor = _worseColor;
    }
    _valueLabel.textColor = textColor;
}


- (void)setHidden:(BOOL)hidden
{
    _hidden = hidden;
    
    _valueLabel.hidden = hidden;
    
    if (hidden) {
        [_valueLabel removeFromSuperview];
        [self resetDisplayLink];
        
    } else {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:_valueLabel];
        [self setDisplayLink];
    }
    
}

- (void)resetDisplayLink
{
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}
- (void)setDisplayLink {
    
    [self resetDisplayLink];
    // 初始化CADisplayLink
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTicks:)];
    // 把CADisplayLink对象加入runloop
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkTicks:(CADisplayLink *)link {
    if (_lastTimestamp == 0) {
        _lastTimestamp = link.timestamp;
        return;
    }
    // 累加方法执行的次数
    _performTimes ++;
    // 记录执行的时间
    NSTimeInterval interval = link.timestamp - _lastTimestamp;
    // 当时间经过一秒的时候再计算FPS，否则计算的太过频繁
    if (interval < 1) { return; }
    _lastTimestamp = link.timestamp;
    // iOS正常刷新率为每秒60次，执行次数/时间
    double fps = _performTimes / interval;
    // 重新初始化记录值
    _performTimes = 0;
    // 把计算的值传出去
    [self refreshWithFPSValue:fps];
}


@end


@interface FPSLabel ()

@property (nonatomic, assign) CGPoint lastPosition;

@property (nonatomic, assign) CGPoint lastPositionInSelf;


@end


@implementation FPSLabel

- (instancetype)init
{
    if (self = [super init]) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGSize fpsSize = CGSizeMake(70, 30);
        self.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = 15;
        self.userInteractionEnabled = YES;
        CGFloat y = 20;
        if (@available(iOS 11, *)) {
            y = [UIApplication sharedApplication].delegate.window.safeAreaInsets.top ? : 20;
        }
        self.frame = CGRectMake(screenSize.width - fpsSize.width - 16, y, fpsSize.width, fpsSize.height);
    }
    return self;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _lastPosition = [touches.anyObject locationInView:self.superview];
    _lastPositionInSelf = [touches.anyObject locationInView:self];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint currentPosition = [touches.anyObject locationInView:self.superview];
    if (CGPointEqualToPoint(currentPosition, _lastPosition)) return;
    
    CGSize size = self.bounds.size;
    CGFloat x = currentPosition.x + (size.width * 0.5 - _lastPositionInSelf.x);
    CGFloat y = currentPosition.y + (size.height * 0.5 - _lastPositionInSelf.y);
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //floatBtnWidth * 0.5 <= x <= screenW - floatBtnWidth * 0.5
    x = MAX(size.width * 0.5, MIN(x, screenW - size.width * 0.5));
    //floatBtnWidth * 0.5 <= y <= screenH - floatBtnWidth * 0.5
    y = MAX(size.height * 0.5, MIN(y, screenH - size.height * 0.5));
    
    CGFloat top = 0, bottom = 0;
    
    if (@available(iOS 11, *)) {
        top = [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;
        bottom = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
    }
    y = MAX(size.height * 0.5 + top, MIN(y, screenH - size.height * 0.5 - bottom));
    
    self.center = CGPointMake(x, y);

}



@end

