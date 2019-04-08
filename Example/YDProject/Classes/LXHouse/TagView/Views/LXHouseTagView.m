//
//  LXHouseTagView.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXHouseTagView.h"

@interface LXHouseTagFlowLayout : UICollectionViewFlowLayout



@end


@implementation LXHouseTagFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    
    CGSize size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    static UICollectionViewLayoutAttributes *attr1 = nil;
    if (indexPath.row == 0) {
        attr.frame = CGRectMake(0, 0, size.width, size.height);
    } else {
        CGFloat x = attr1.frame.origin.x + attr1.frame.size.width + self.minimumInteritemSpacing;
        CGFloat viewWidth = CGRectGetWidth(self.collectionView.frame) - x;
        
        if (viewWidth >= size.width) {
            attr.frame = CGRectMake(x, attr1.frame.origin.y, size.width, size.height);
        } else {
            CGFloat y = attr1.frame.origin.y + attr1.bounds.size.height + self.minimumLineSpacing;
            attr.frame = CGRectMake(0, y, size.width, size.height);
        }
    }
    attr1 = attr;
    return attr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger section = [self.collectionView numberOfSections];
    
    for (int b = 0; b < section; b ++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:b];
        //add cells
        for (int i=0; i<count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:b];
            
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [array addObject:attributes];
        }
        
    }
    return array;
}
@end






@interface LXHouseTagView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong) UICollectionView *collectionView;


@end

@implementation LXHouseTagView


- (instancetype)init
{
    if (self = [super init]) {
        [self setupConfiguration];
    }
    
    return self;
}






- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupConfiguration];
    }
    
    return self;
}

- (void)setupConfiguration
{
    
    self.tagsArray = @[@"托尔斯泰", @"tdsfsdfs", @"电费水费", @"打得过大公鸡分公司", @"d", @"dgsdfhggksdkfg"];
    
    [self setupUI];
}


- (void)setupUI
{
    [self addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}


- (void)reloadData
{
    [self.collectionView reloadData];
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXTagViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 20);
}


#pragma mark - lazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        LXHouseTagFlowLayout *layout = [[LXHouseTagFlowLayout alloc] init];
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 10.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LXTagViewCell"];
    }
    
    return _collectionView;
}



@end
