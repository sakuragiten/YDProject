//
//  TestViewModel.h
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestModel.h"

typedef NS_ENUM(NSUInteger, TestViewModelType){
    TestViewModelTypeDefault = 0,
    TestViewModelTypeOpenGL = 1,
    TestViewModelTypeCoreGraphics = 2,
    TestViewModelTypeCoreBasic = 3,
    TestViewModelTypeLXHouse = 4,
    TestViewModelTypeLXBroker = 5,
};

NS_ASSUME_NONNULL_BEGIN

@interface TestViewModel : NSObject

- (instancetype)initWithViewModelType:(TestViewModelType)type;

@property (nonatomic, strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
