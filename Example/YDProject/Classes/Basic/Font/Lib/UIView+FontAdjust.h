//
//  UIView+FontAdjust.h
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/4/22.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FontAdjust)

- (CGRect)sx_fontAdjustFrame;
- (CGSize)sx_fontAdjustSize;

- (void)sx_fontDidChanged;

@property (nonatomic, copy) CGSize (^sx_fontAdjustSizeHandle)();
@property (nonatomic, copy) CGRect (^sx_fontAdjustFrameHandle)();

@property (nonatomic, copy) void (^sx_reMakeConstraints)(MASConstraintMaker *make);


@end


@interface UILabel (FontAdjust)

@end


NS_ASSUME_NONNULL_END
