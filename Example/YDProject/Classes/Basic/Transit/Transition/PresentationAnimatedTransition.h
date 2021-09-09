//
//  PresentationAnimatedTransition.h
//  JMPanKeTong
//
//  Created by louxunmac on 2019/11/5.
//  Copyright © 2019 Qfang.com. All rights reserved.
//

#import <Foundation/Foundation.h>





typedef NS_ENUM(NSInteger, TransitionStyle) {
    TransitionStylePresentation,
    TransitionStyleDismissal,
};


NS_ASSUME_NONNULL_BEGIN

@interface PresentationAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>


- (instancetype)initWithTransitionStyle:(TransitionStyle)transitionStyle;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
