//
//  LXBrokerCardView.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXBrokerCardView.h"
#import "LXPageControl.h"
#import "LXPopLabel.h"

@interface LXBrokerCardView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

/** page control */
@property (nonatomic, strong) LXPageControl *pageConrol;



@end


@implementation LXBrokerCardView



- (instancetype)init
{
    if (self = [super init]) {
        [self initialCardView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialCardView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialCardView];
    }
    return self;
}


- (void)initialCardView
{
    [self configuration];
    [self setupUI];
    [self bindBusiness];
}

- (void)setupUI
{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageConrol];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(122.0);
    }];
    
    [_pageConrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(15.0);
        make.centerX.equalTo(self.collectionView);
    }];
    
    
    LXPopLabel *popLabel = [LXPopLabel new];
    popLabel.text = @"↑这是一段测试文字";
    [self addSubview:popLabel];
    [popLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(17);
        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(40);
        make.centerX.equalTo(self.pageConrol);
    }];
    
}


- (void)configuration
{
    self.numberOfItemPerPage = 3;
}


- (void)bindBusiness
{
    RAC(self.pageConrol, currentPage) = [[[RACObserve(self.collectionView, contentOffset) map:^id(NSValue *value) {
        CGPoint p = value.CGPointValue;
        NSInteger page = floor(p.x / self.collectionView.bounds.size.width);
        return @(page);
    }] filter:^BOOL(id value) {
        NSInteger page = [value integerValue];
        return page >= 0 && page < self.pageConrol.numberOfPages;
    }] distinctUntilChanged];
}








#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.numberOfItemPerPage == 0) return 0;
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCollectonCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger perCount = self.numberOfItemPerPage ? : 1;
    CGFloat w = collectionView.bounds.size.width / perCount;
    CGFloat h = collectionView.bounds.size.height;
    
    return CGSizeMake(w, h);
    
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
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CardCollectonCell"];
        
    }
    
    return _collectionView;
}


- (LXPageControl *)pageConrol
{
    if (!_pageConrol) {
        _pageConrol = [[LXPageControl alloc] init];
        _pageConrol.pageIndicatorTintColor = [UIColor whiteColor];
        _pageConrol.currentPageIndicatorTintColor = [UIColor redColor];
        _pageConrol.numberOfPages = 3;
    }
    
    return _pageConrol;
}





@end
