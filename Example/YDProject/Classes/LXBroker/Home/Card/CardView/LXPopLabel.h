//
//  LXPopLabel.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXPopLabel : UIView


@property (nonnull, nonatomic, copy) NSString *text;

@property (nonnull, nonatomic, strong) UIFont *font;

@property(nonatomic, assign) CGFloat maxWidth;

@property(nonatomic, assign) UIEdgeInsets contentInsets;

@property(nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, strong) UIColor *strokeColor;
@property(nonatomic, assign) CGFloat lineWidth;


@property (nonatomic, strong) UIColor *textColor;



@property(nonatomic, assign) CGSize triangleSize;






@end

NS_ASSUME_NONNULL_END
