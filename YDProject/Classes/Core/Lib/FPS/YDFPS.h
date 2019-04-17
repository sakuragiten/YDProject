//
//  YDFPS.h
//  YDProject
//
//  Created by louxunmac on 2019/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDFPS : NSObject

/** 当前的fps值 */
@property (nonatomic, assign) double value;

/** 流畅 默认绿色 */
@property(nonatomic, strong) UIColor *smoothlyColor;


/** 一般 默认黄色 */
@property(nonatomic, strong) UIColor *normalColor;


/** 卡顿 默认红色 */
@property(nonatomic, strong) UIColor *worseColor;

/** 是否隐藏 默认否 */
@property (nonatomic, assign, getter=isHidden) BOOL hidden;



@end

NS_ASSUME_NONNULL_END


