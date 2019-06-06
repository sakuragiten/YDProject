//
//  LXBrokerCardView.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXBrokerCardView.h"

@interface LXBrokerCardView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end


@implementation LXBrokerCardView



- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    
}








#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    
    return _collectionView;
}


@end
