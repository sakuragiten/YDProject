//
//  PushAnimatedTransition.h
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/6/3.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PushAnimationStyle) {
    PushAnimationStylePush,
    PushAnimationStylePop,
};

@interface PushAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionStyle:(PushAnimationStyle)transitionStyle;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;


@end

NS_ASSUME_NONNULL_END
