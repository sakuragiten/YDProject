//
//  PresentationTransition.h
//  JMPanKeTong
//
//  Created by louxunmac on 2019/11/5.
//  Copyright © 2019 Qfang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractiveTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface PresentationTransition : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) InteractiveTransition *interactiveTransition;

@end

NS_ASSUME_NONNULL_END
