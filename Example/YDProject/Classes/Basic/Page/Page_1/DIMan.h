//
//  DIMan.h
//  YDProject_Example
//
//  Created by gongsheng on 2019/3/1.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "DIPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface DIMan : DIPerson

- (instancetype)initWithAge:(NSString *)age NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy) NSString *age;

@end

NS_ASSUME_NONNULL_END
