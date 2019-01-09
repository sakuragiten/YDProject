//
//  YDTest.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/6/12.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import "YDTest.h"

@implementation YDTest




//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
//{
//    if ([key isEqualToString:@"name"]) {
//        return NO; //不自动触发监听
//    }
//    return YES;
//}

//+ (BOOL)automaticallyNotifiesObserversOfName
//{
//    return NO;
//}



//需要监听成员变量某个特定的值
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keySet = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"person"]) {
        NSSet *set = [NSSet setWithObject:@"_person.age"];
        keySet = [keySet setByAddingObjectsFromSet:set];
    }

    return keySet;


}



@end
