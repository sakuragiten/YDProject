//
//  LXHouseAlbumController.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXNewHouseImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXHouseAlbumController : UIViewController

@property(nonatomic, assign) NSInteger currentIndex;

@property(nonatomic, copy) NSArray<LXNewHouseImageModel *> *imageModelArray;

@end






@interface LXHouseAlbumNavigationView : UIView

@property (nonatomic, copy) NSString *title;

@property(nonatomic, strong) RACCommand *backAction;


- (void)setNavigationView:(BOOL)hidden animated:(BOOL)animated;


@end





@class LXAlbumTitlesView;

@protocol LXAlbumTitlesDelegate <NSObject>

@optional

- (void)albumTitleView:(LXAlbumTitlesView *)titleView didSelectTitle:(NSString *)title atIndex:(NSInteger)index;

@end

@interface LXAlbumTitlesView : UIView


@property(nonatomic, strong) UILabel *titleLabel;

/** title */
@property(nonatomic, copy) NSArray<NSString *> *titlesArray;

/** default is 0 */
@property (nonatomic, assign) NSInteger selectIndex;



- (void)setAlbumTitleView:(BOOL)hidden animated:(BOOL)animated;


@property (nonatomic, weak) id<LXAlbumTitlesDelegate> delegate;


@end










NS_ASSUME_NONNULL_END
