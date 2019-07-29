//
//  UIView+Mark.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/7/25.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "UIView+Mark.h"

@implementation UIView (Mark)


- (UIImage *)lx_renderImage
{
    CGSize viewSize = self.bounds.size;
    NSLog(@"%@", NSStringFromCGSize(viewSize));
    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (UIImage *)lx_renderNormalImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}




@end
