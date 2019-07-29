//
//  LXBroadcastView.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/12.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXBroadcastView.h"

@interface LXBroadcastView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSMutableArray *contentArray;


@property (nonatomic, strong) NSTimer *timer;


@end

@implementation LXBroadcastView


- (instancetype)init
{
    if (self = [super init]) {
        [self initialConfiguration];
    }
    
    return self;
}

- (void)initialConfiguration
{
    self.timerInterval = 3.0;
    self.clipsToBounds = YES;
    [self setupUI];
}


- (void)setupUI
{
    
    [self addSubview:self.contentView];
    
}


- (void)layoutSubviews
{
    CGRect frame = self.bounds;
    frame.size.height = frame.size.height * 2;
    _contentView.frame = frame;
    if (self.bounds.size.width > 0) [self reloadData];
}



- (void)reloadData
{
    
    
    NSInteger count = self.dataArray.count > 1 ? 2 : self.dataArray.count;
    
    [self resetContent];
    if (count == 0) return;
    
    [self addContentViewWithCount:count];

    if (count > 1) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(setContentPosition) userInfo:nil repeats:YES];
    }
    
}

- (void)resetContent
{
    for (UIView *view in self.contentArray) {
        [view removeFromSuperview];
    }
    [self.contentArray removeAllObjects];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}



- (void)addContentViewWithCount:(NSInteger)count
{
    for (int i = 0; i < count; i ++) {
        LXBroadcastContentView *view = [LXBroadcastContentView new];
        CGSize size = self.bounds.size;
        view.frame = CGRectMake(0, size.height * i, size.width, size.height);
        [self.contentView addSubview:view];
        [self.contentArray addObject:view];
        [self setContentView:view atIndex:i];
    }
}



- (void)setContentPosition
{
    self.selectIndex = ++self.selectIndex % self.dataArray.count;
    CGFloat y = self.bounds.size.height;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = CGRectMake(0, -y, self.bounds.size.width, y * 2);
    } completion:^(BOOL finished) {
        [self adjustScrollContent];
    }];
    

    
}

- (void)adjustScrollContent
{
    //将第一个内容 改为当前内容
    [self setContentView:self.contentArray.firstObject atIndex:self.selectIndex];
    //回到第一个位置

    CGSize size = self.bounds.size;
    self.contentView.frame = CGRectMake(0, 0, size.width, size.height * 2);
    //改变第二个内容为下一个内容
    NSInteger index = (self.selectIndex + 1) % self.dataArray.count;
    [self setContentView:self.contentArray.lastObject atIndex:index];

}

- (void)setContentView:(LXBroadcastContentView *)contentView atIndex:(NSInteger)index
{
    NSDictionary *dict = self.dataArray[index];
    contentView.titleLabel.text = dict[@"title"];
    contentView.contentLabel.text = dict[@"content"];
    contentView.subTitleLabel.text = dict[@"subTitle"];
    contentView.subContentLabel.text = dict[@"subContent"];
}


#pragma mark - getter


- (NSMutableArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    
    return _contentArray;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}


@end




@implementation LXBroadcastContentView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.subContentLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(self.titleLabel.mas_right).offset(15.0);
    }];

    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(self.contentLabel.mas_right).offset(15.0);
    }];

    [_subContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(self.subTitleLabel.mas_right).offset(9.0);
        make.right.mas_equalTo(-18.0).priority(750);
    }];
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#79808A"];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
     
    }
    
    return _titleLabel;
}


- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#79808A"];
        _contentLabel.font = [UIFont systemFontOfSize:10];
        [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [_contentLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
     
    }
    return _contentLabel;
}


- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textColor = [UIColor colorWithHexString:@"#79808A"];
        _subTitleLabel.font = [UIFont systemFontOfSize:10];
        [_subTitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [_subTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
  

    }
    return _subTitleLabel;
}


- (UILabel *)subContentLabel
{
    if (!_subContentLabel) {
        _subContentLabel = [UILabel new];
        _subContentLabel.textColor = [UIColor colorWithHexString:@"#131319"];
        _subContentLabel.font = [UIFont systemFontOfSize:12];
        [_subContentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [_subContentLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
       
    }
    return _subContentLabel;
}

@end


