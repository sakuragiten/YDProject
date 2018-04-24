//
//  YDMap.m
//  Pods
//
//  Created by gongsheng on 24/04/2018.
//

#import "YDMap.h"

@interface YDMap ()

@property (nonatomic, strong) NSMutableDictionary *data_dict;

@property (nonatomic, strong) NSMutableArray *data_array;


/** 所有的key */
//@property (nonatomic, strong) NSArray *allKeys;
//
///** 所有的value */
//@property (nonatomic, strong) NSArray *allValues;

@end


@implementation YDMap

// MARK: - 所有的key
- (NSArray *)allKeys
{
    return self.data_array;
}

- (NSArray *)allValues
{
    NSMutableArray *tmp = [NSMutableArray array];
    for (id key in self.data_array) {
        [tmp addObject:[self.data_dict objectForKey:key]];
    }
    return tmp;
}


// MARK: - 添加
- (void)setObject:(id)obj forkey:(id <NSCopying>)aKey
{
    NSAssert(obj && aKey, @"obj or aKey can not be nil");
    [self.data_dict setObject:obj forKey:aKey];
    if (![self.data_array containsObject:aKey]) [self.data_array addObject:aKey];
    
}
// MARK: - 删除
- (void)removeObjectForKey:(NSString *)aKey
{
    [self.data_dict removeObjectForKey:aKey];
    [self.data_array removeObject:aKey];
}




// MARK: - 通过下标访问数据
- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    NSString *key = _data_array[index];
    return _data_dict[key];
}

// MARK: - 通过key访问数据
- (id)objectForKeyedSubscript:(id<NSCopying>)key
{
    return _data_dict[key];
}


/** 访问对象 */
- (id)objectForKey:(id <NSCopying>)aKey
{
    return self.data_dict[aKey];
}
- (id)objectAtIndex:(NSUInteger)index
{
    id key = self.data_array[index];
    return [self objectForKey:key];
}

// MARK: - 通过key添加数据
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)aKey
{
    [self setObject:obj forkey:aKey];
}

#pragma mark - lazyload
- (NSMutableDictionary *)data_dict
{
    if (!_data_dict) {
        _data_dict = [NSMutableDictionary dictionary];
    }
    return _data_dict;
}



- (NSMutableArray *)data_array
{
    if (!_data_array) {
        _data_array = [NSMutableArray array];
    }
    return _data_array;
}

@end
