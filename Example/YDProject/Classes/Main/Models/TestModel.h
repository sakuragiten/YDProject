//
//  TestModel.h
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Test(title, name) [[TestModel alloc] initWithTitle:title className:name]

@interface TestModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *className;

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
