//
//  DIPerson.h
//  YDProject_Example
//
//  Created by gongsheng on 2019/3/1.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DIPerson : NSObject

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER; 

@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
