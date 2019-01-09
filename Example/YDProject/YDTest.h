//
//  YDTest.h
//  YDProject_Example
//
//  Created by gongsheng on 2018/6/12.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDPerson.h"

@interface YDTest : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, strong) YDPerson *person;

@end
