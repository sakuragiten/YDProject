//
//  BehaviorView.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2022/5/7.
//  Copyright © 2022 387970107@qq.com. All rights reserved.
//

#import "BehaviorView.h"

#define b_angle(r)  ((r) / 180.0 * M_PI)

@interface BehaviorView ()

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIImageView *scoreImageView;

@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation BehaviorView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}


- (void)setupView
{
    _titleLable = [UILabel new];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor colorWithHexString:@"#666666"];
    _titleLable.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    _titleLable.text = @"    行为分";
    _titleLable.layer.cornerRadius = 11.0;
    _titleLable.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self addSubview:_titleLable];
    
    _scoreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_behavior_score_bg"]];
    _scoreImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_scoreImageView];
    
    
    _scoreLabel = [UILabel new];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    [_scoreImageView addSubview:_scoreLabel];
    
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(72, 22));
    }];
    
//    [_scoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.centerY.equalTo(self.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//    }];
    // 使用 Mansonry会影响锚点的位置
    _scoreImageView.frame = CGRectMake(0, 0, 40, 40);
//    _scoreImageView.backgroundColor = [UIColor redColor];
    
    self.scoreImageView.layer.anchorPoint = CGPointMake(0.5, 0.7);
    self.scoreImageView.layer.position = CGPointMake(20,28);
    
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.scoreImageView);
        make.size.mas_equalTo(CGSizeMake(22, 12));
    }];
    
}


- (void)setScore:(NSInteger)score
{
    _score = score;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", self.score];
}


- (void)startAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.values = @[@(b_angle(0)), @(b_angle(-20)), @(b_angle(15)), @(b_angle(-10)), @(b_angle(0))];
    animation.keyTimes = @[@0, @(0.4), @(0.7), @(0.9), @(1)];
    animation.repeatCount = 1;
    animation.duration = 0.8;
    
    [self.scoreImageView.layer addAnimation:animation forKey:@"be_animation"];
    
}

@end
