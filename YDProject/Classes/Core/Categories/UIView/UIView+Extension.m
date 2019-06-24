//
//  UIView+Extension.m
//  YDProject
//
//  Created by louxunmac on 2019/4/16.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

@dynamic borderWidth;
@dynamic borderColor;
@dynamic cornerRadius;






- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth < 0) return;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    
    self.layer.cornerRadius = cornerRadius;
//    self.layer.masksToBounds = (cornerRadius != 0);
}







@end






