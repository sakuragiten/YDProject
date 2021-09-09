//
//  SXCompositionalLayout.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/3/31.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "SXCompositionalLayout.h"

@implementation SXCompositionalLayout

- (void)prepareLayout
{
    [super prepareLayout];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    id<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> delegate = (id<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>)self.collectionView.delegate;
    
    
    NSInteger count = [delegate collectionView:self.collectionView numberOfItemsInSection:0];
    CGFloat width = self.collectionView.bounds.size.width;
    CGSize size;
    if (count < 3) {
        CGFloat item_w = (width - self.minimumInteritemSpacing) * 0.5;
        size = CGSizeMake(item_w, item_w);
    } else {
        // 上面三个 下面三个 宽度不一样
        CGFloat item_width = indexPath.row < 3 ? (width - self.minimumInteritemSpacing) / 3.0 : (width - self.minimumInteritemSpacing * 2) / 3.0;
        if (indexPath.row == 0) {
            size = CGSizeMake(item_width * 2, item_width * 2 + self.minimumLineSpacing);
        } else {
            size = CGSizeMake(item_width, item_width);
            if (indexPath.row == count - 1)  {
                NSInteger item_index = (indexPath.row - 3) % 3;
                CGFloat item_x = item_index * (item_width + self.minimumInteritemSpacing);
                size.width = width - item_x;
            }
        }
    }
    static UICollectionViewLayoutAttributes *lastAttr = nil;
    if (indexPath.row == 0) {
        attr.frame = CGRectMake(0, 0, size.width, size.height);
    } else if (indexPath.row == 1) {
        CGFloat x = lastAttr.frame.origin.x + lastAttr.frame.size.width + self.minimumInteritemSpacing;
        attr.frame = CGRectMake(x, 0, size.width, size.height);
    } else if (indexPath.row == 2) {
        CGFloat x = lastAttr.frame.origin.x;
        CGFloat y = lastAttr.frame.origin.y + lastAttr.frame.size.height + self.minimumLineSpacing;
        attr.frame = CGRectMake(x, y, size.width, size.height);
    } else {
        NSInteger item_index = (indexPath.row - 3) % 3;
        CGFloat x = item_index * (lastAttr.frame.size.width + self.minimumInteritemSpacing);
        CGFloat last_maxY = lastAttr.frame.origin.y + lastAttr.frame.size.height;
        CGFloat y = item_index == 0 ? last_maxY + self.minimumLineSpacing : lastAttr.frame.origin.y;
        attr.frame = CGRectMake(x, y, size.width, size.height);
    }
    lastAttr = attr;
    
    return attr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger section = [self.collectionView numberOfSections];
    
    for (int b = 0; b < section; b ++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:b];
        //add cells
        for (int i = 0; i < count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:b];
            
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [array addObject:attributes];
        }
        
    }
    return array;
}
@end
