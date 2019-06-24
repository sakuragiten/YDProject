//
//  LXPageControl.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@class LXPageControl;

@protocol LXPageControlProtocol <NSObject>

@optional
- (CGSize)sizeForSeletItem;
- (CGSize)sizeForNormalItem;



@end


@interface LXPageControl : UIControl

/** 页码数  default is 0 */
@property(nonatomic) NSInteger numberOfPages;

/** 当前的页码数 default is 0 */
@property(nonatomic) NSInteger currentPage;

/** 只有一页时候是否显示  default is NO */
@property(nonatomic) BOOL hidesForSinglePage;

/** 正常状态下的页码图片 */
@property (nonatomic, strong) UIImage *normalImage;

/** 选中时候的图片 */
@property (nonatomic, strong) UIImage *selectImage;

@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

/** distance between two item, default is 4.0 */
@property(nonatomic, assign) CGFloat itemSpace;



@property (nonatomic, weak) id<LXPageControlProtocol> delegate;



@end

