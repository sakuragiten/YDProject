//
//  UIView+Extension.h
//  YDProject
//
//  Created by louxunmac on 2019/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)


//边框宽度
@property (nonatomic, assign ) IBInspectable CGFloat borderWidth;

//可视化设置边框颜色
@property (nonatomic, strong ) IBInspectable UIColor *borderColor;

//可视化设置圆角
@property (nonatomic, assign ) IBInspectable CGFloat cornerRadius;


@end

NS_ASSUME_NONNULL_END
