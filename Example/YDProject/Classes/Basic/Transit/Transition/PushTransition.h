//
//  PushTransition.h
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractiveTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushTransition : NSObject<UINavigationControllerDelegate>

@property (nonatomic, strong) InteractiveTransition *interactiveTransition;

@end

NS_ASSUME_NONNULL_END
