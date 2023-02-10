//
//  ChatAnimationCell.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/6/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "ChatAnimationCell.h"

@interface ChatAnimationCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *headImageView;


@end

@implementation ChatAnimationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    _headImageView = [UIImageView new];
    _headImageView.layer.cornerRadius = 4.0;
    _headImageView.layer.backgroundColor = [UIColor randomColor].CGColor;
    [self.contentView addSubview:_headImageView];
    
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.backgroundColor = [UIColor greenColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLabel];
}

- (void)setModel:(ChatModel *)model
{
    _model = model;

    _contentLabel.text = model.content;

    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil];
    CGFloat width = rect.size.width + 20;

    if (model.showAnimation) {
        [self showAnimationWithContentWitdth:width];
    } else {
        self.headImageView.frame = CGRectMake(10, 10, 40, 40);
        self.contentLabel.frame =  CGRectMake(60, 10, width, 30);
    }
}

//
- (void)showAnimationWithContentWitdth:(CGFloat)width
{
    _headImageView.frame = CGRectMake(10, 10, 0, 0);
    _contentLabel.frame =  CGRectMake(60, 10, 0, 0);

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.headImageView.frame = CGRectMake(10, 10, 40, 40);
        self.contentLabel.frame =  CGRectMake(60, 10, width, 30);
    } completion:^(BOOL finished) {

    }];
    self.model.showAnimation = NO;
}




//- (void)showAnimationWithContentWitdth:(CGFloat)width
//{
//    _headImageView.frame = CGRectMake(10, 10, 0, 0);
//    _contentLabel.frame =  CGRectMake(60, 10, 0, 0);
//    CGFloat scale = 1.5;
//    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
//            self.headImageView.frame = CGRectMake(10, 10, 40 * scale, 40 * scale);
//            self.contentLabel.frame =  CGRectMake(20 + 40 * scale, 10, width * scale, 30 * scale);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.2 animations:^{
//            self.headImageView.frame = CGRectMake(10, 10, 40, 40);
//            self.contentLabel.frame =  CGRectMake(60, 10, width, 30);
//        }];
//
//    } completion:^(BOOL finished) {
//
//    }];
//
//    self.model.showAnimation = NO;
//}






@end
