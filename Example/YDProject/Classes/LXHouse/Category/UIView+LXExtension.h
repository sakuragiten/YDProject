//
//  UIView+LXExtension.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/15.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LXExtension)



/** 设置渐变layer (楼讯style) */
- (void)lx_settingGradientLayer;

/**
 给View 设置渐变色

 @param fromColor 起始颜色
 @param toColor 结束颜色
 */
- (void)lx_settingGradientLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;



/**
 给View 设置渐变色

 @param configuration 根据需要配置 如果为nil 则使用默认的 即楼讯style
 */
- (void)lx_settingGradientLayer:(void(^)(CAGradientLayer *layer))configuration;



@end

typedef NS_ENUM(NSUInteger, LXButtonCoententStyle) {
    LXButtonCoententImageTop,   //图片在上
    LXButtonCoententImageLeft,  //图片在左
    LXButtonCoententImageBottom,//图片在下
    LXButtonCoententImageRight, //图片在又
};


@interface UIButton (LXExtension)

- (void)lx_reloadContentWithStyle:(LXButtonCoententStyle )style;

@end




NS_ASSUME_NONNULL_END
