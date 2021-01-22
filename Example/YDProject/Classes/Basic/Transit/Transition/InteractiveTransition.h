//
//  InteractiveTransition.h
//  JMPanKeTong
//
//  Created by louxunmac on 2019/11/5.
//  Copyright © 2019 Qfang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InteractiveMode) {
    InteractiveModeNone = 0,
    InteractiveModeSideslip,    // 侧滑返回
    InteractiveModeDragDown,    // 向下拖拽返回
};

//手势控制哪种转场
typedef NS_ENUM(NSUInteger, InteractiveTransitionType) {
    InteractiveTransitionTypePresent = 0,
    InteractiveTransitionTypeDismiss,
    InteractiveTransitionTypePush,
    InteractiveTransitionTypePop,
};


NS_ASSUME_NONNULL_BEGIN

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interactive;

@property(nonatomic, assign) InteractiveMode interactiveMode;

@property (nonatomic, assign) InteractiveTransitionType type;


- (instancetype)initWithInteractiveMode:(InteractiveMode)interactiveMode transitionType:(InteractiveTransitionType)type;


- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
