//
//  LXPageControl.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXPageControl.h"


@interface LXPageControl ()

@property (nonatomic, strong) NSMutableArray *pageArray;


@end


@implementation LXPageControl

- (instancetype)init
{
    if (self = [super init]) {
        [self initialSetting];
    }
    
    return self;
}

- (void)initialSetting
{
    self.itemSpace = 4.0;
}


- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    if (self.pageArray.count != numberOfPages) {
        [self setupPageView];
    }
}


- (void)setupPageView
{
    [self removeAllPages];
    
    for (int i = 0; i < _numberOfPages; i ++) {
        UIImageView *imageView = [UIImageView new];
        [self.pageArray addObject:imageView];
        [self addSubview:imageView];
    }
    
    
}

- (void)reloadData
{
    UIImageView *last = nil;
    for (int i = 0; i < self.pageArray.count; i ++) {
        UIImageView *imageView = self.pageArray[i];
        BOOL selected = i == _currentPage;
        CGSize size = [self imageViewSize:selected];
        imageView.layer.cornerRadius = size.height * 0.5;
        imageView.layer.masksToBounds = YES;
        [self settingImageView:imageView selected:selected];
        
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            last ? make.left.equalTo(last.mas_right).offset(self.itemSpace) : make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(size);
            if (i == self.pageArray.count - 1) {
                make.right.mas_equalTo(0).priority(750);
            }
        }];
        last = imageView;
    }
    
}



- (void)didMoveToWindow
{
    [self reloadData];
}


- (void)removeAllPages
{
    for (UIImageView *imageView in self.subviews) {
        [imageView removeFromSuperview];
    }
    [self.pageArray removeAllObjects];
}


#pragma mark - set

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self reloadData];
}

- (void)settingImageView:(UIImageView *)imageView selected:(BOOL)selected
{
    imageView.image = selected ? self.selectImage : self.normalImage;
    imageView.backgroundColor = selected ? self.currentPageIndicatorTintColor : self.pageIndicatorTintColor;
}


#pragma mark - getter
- (CGSize)imageViewSize:(BOOL)selected
{
    return selected ? [self selectSize] : [self normalSize];
}

- (CGSize)selectSize
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sizeForSeletItem)]) {
        return [self.delegate sizeForSeletItem];
    } else {
        return CGSizeMake(13.0, 4.0);
    }
}

- (CGSize)normalSize
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sizeForNormalItem)]) {
        return [self.delegate sizeForNormalItem];
    } else {
        return CGSizeMake(6.0, 4.0);
    }
}



- (NSMutableArray *)pageArray
{
    if (!_pageArray) {
        _pageArray = [NSMutableArray array];
    }
    
    return _pageArray;
}

@end
