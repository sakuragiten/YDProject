//
//  YDMap.h
//  Pods
//
//  Created by gongsheng on 24/04/2018.
//

#import <Foundation/Foundation.h>

@interface YDMap : NSObject

/** 所有的key */
@property (nonatomic, strong, readonly) NSArray *allKeys;

/** 所有的value */
@property (nonatomic, strong, readonly) NSArray *allValues;

/** 添加对象 */
- (void)setObject:(id)obj forkey:(id <NSCopying>)aKey;

/** 访问对象 */
- (id)objectForKey:(id <NSCopying>)aKey;
- (id)objectAtIndex:(NSUInteger)index;

/** 移除对象 */
- (void)removeObjectForKey:(NSString *)aKey;

/** 通过下标访问数据 */
- (id)objectAtIndexedSubscript:(NSUInteger)index;

/** 通过key访问数据 */
- (id)objectForKeyedSubscript:(id <NSCopying>)key;

/** 通过key添加数据 */
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)aKey;

@end
