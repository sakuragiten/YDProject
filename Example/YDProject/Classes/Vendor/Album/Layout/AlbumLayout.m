//
//  AlbumLayout.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/5/28.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "AlbumLayout.h"

@implementation AlbumLayout


- (void)prepareLayout
{
    [super prepareLayout];
    
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (int i = 1; i < array.count; i ++) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = array[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = array[i - 1];
        
        NSInteger maximumSpacing = 0;
        NSInteger maxX = CGRectGetMaxX(prevLayoutAttributes.frame);
        if(maxX + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = maxX + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return array;
}

@end
