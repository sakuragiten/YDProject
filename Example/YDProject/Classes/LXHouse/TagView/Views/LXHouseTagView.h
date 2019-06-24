//
//  LXHouseTagView.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class LXHouseTagStyle;

@interface LXHouseTagView : UIView


@property(nonatomic, copy) NSArray<NSString *> *tagsArray;


@property(nonatomic, copy) void (^heightRefresh)(CGFloat height);


/** max number of lines,  deafult is 0 */
@property(nonatomic, assign) NSInteger maxNumberOfLines;

/** max number of tags, deafult is 0 */
@property(nonatomic, assign) NSInteger maxNumberOfTags;

@property(nonatomic, assign) CGFloat minimumLineSpacing;

@property(nonatomic, assign) CGFloat minimumInteritemSpacing;



- (void)reloadTagView:(NSArray<NSString *> *)tagsArray heightRefresh:(void (^)(CGFloat height))heightRefresh;

- (void)reloadData;



/**
 tag显示的样式的设置 （有特殊样式的时候使用）

 @param styleHandle 根据title设置指定的样式
 */
- (void)settingTagStyle:(void(^)(LXHouseTagStyle *syle, NSString *title))styleHandle;


/**
 内容显示的边距 默认为{0, 0, 0 ,0}
 */
@property (nonatomic, assign) UIEdgeInsets contentEdge;


/**
 文字距tag边缘的距离 默认为{3, 10, 3, 10}
 */
@property (nonatomic, assign) UIEdgeInsets textEdge;



/**
 文字的字体 默认10号字体（Medium）
 */
@property(nonatomic, strong) UIFont *font;



/**
 tag 是否支持滚动 默认为 NO
 */
@property (nonatomic, assign) BOOL scrollEnable;




@end




@interface LXHouseTagStyle : NSObject

/** 圆角 默认2*/
@property(nonatomic, assign) CGFloat cornerRadius;

/** 边框 默认0*/
@property(nonatomic, assign) CGFloat borderWidth;

/** 边框颜色 */
@property(nonatomic, strong) UIColor *borderColor;

/** 文字颜色 */
@property(nonatomic, strong) UIColor *textColor;

/** 背景颜色 */
@property(nonatomic, strong) UIColor *backgroundColor;

/** 默认的样式 */
+ (instancetype)defaultStyle;

/** 样式的数据集合 */
+ (NSDictionary *)houseTagStyleDict;

@end


NS_ASSUME_NONNULL_END
