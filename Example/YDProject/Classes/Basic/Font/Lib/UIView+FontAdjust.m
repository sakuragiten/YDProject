//
//  UIView+FontAdjust.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/4/22.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "UIView+FontAdjust.h"

#import <objc/runtime.h>

@implementation UIView (FontAdjust)

+ (void)load
{
    
    SEL originalSelector = @selector(mas_makeConstraints:);
    SEL targetSelector = @selector(sx_makeConstraints:);
    Method originalMethod = class_getInstanceMethod([self class], originalSelector);
    Method targetMethod = class_getInstanceMethod(self, targetSelector);
    
    method_exchangeImplementations(originalMethod, targetMethod);
}



- (CGRect)sx_fontAdjustFrame
{
    return self.frame;
}


- (CGSize)sx_fontAdjustSize
{
    return [self sx_fontAdjustFrame].size;
}

- (void)sx_fontDidChanged
{
    if (self.sx_reMakeConstraints) {
        [self mas_remakeConstraints:self.sx_reMakeConstraints];
    } else {
        CGRect frame = [self sx_fontAdjustFrame];
        if (self.sx_fontAdjustFrameHandle) {
            frame = self.sx_fontAdjustFrameHandle();
        } else if (self.sx_fontAdjustSizeHandle) {
            frame.size = self.sx_fontAdjustSizeHandle();
        }
        self.frame = frame;
    }
    
    [self.superview sx_fontDidChanged];
}





- (NSArray *)sx_makeConstraints:(void (^)(MASConstraintMaker *))block {
    if (self.sx_reMakeConstraints == nil) {
        self.sx_reMakeConstraints = block;
    }
    return [self sx_makeConstraints:block];
}



- (void)setSx_fontAdjustSizeHandle:(CGSize (^)())sx_fontAdjustSizeHandle
{
    objc_setAssociatedObject(self, @"sx_fontAdjustSizeHandle", sx_fontAdjustSizeHandle, OBJC_ASSOCIATION_COPY);
}

- (CGSize (^)())sx_fontAdjustSizeHandle
{
    return objc_getAssociatedObject(self, @"sx_fontAdjustSizeHandle");
}

- (void)setSx_fontAdjustFrameHandle:(CGRect (^)())sx_fontAdjustFrameHandle
{
    objc_setAssociatedObject(self, @"sx_fontAdjustFrameHandle", sx_fontAdjustFrameHandle, OBJC_ASSOCIATION_COPY);
}


- (CGRect (^)())sx_fontAdjustFrameHandle
{
    return objc_getAssociatedObject(self, @"sx_fontAdjustFrameHandle");
}


- (void)setSx_reMakeConstraints:(void (^)(MASConstraintMaker * _Nonnull))sx_reMakeConstraints
{
    objc_setAssociatedObject(self, @"sx_reMakeConstraints", sx_reMakeConstraints, OBJC_ASSOCIATION_COPY);
}

- (void (^)(MASConstraintMaker * _Nonnull))sx_reMakeConstraints
{
    return objc_getAssociatedObject(self, @"sx_reMakeConstraints");
}



@end



@implementation UILabel (FontAdjust)


- (CGRect)sx_fontAdjustFrame
{
    CGRect frame = self.frame;
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(200, 500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil];
    CGSize size = CGSizeMake(rect.size.width + 4, rect.size.height + 2);
    frame.size = size;
    return frame;
}


@end
