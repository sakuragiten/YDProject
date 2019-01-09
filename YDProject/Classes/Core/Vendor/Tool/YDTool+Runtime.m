//
//  YDTool+Runtime.m
//  YDProject
//
//  Created by gongsheng on 2018/12/4.
//

#import "YDTool+Runtime.h"
#import <objc/runtime.h>
@implementation YDTool (Runtime)

+ (NSArray *)findSubClass:(Class)defaultClass
{
    int count = objc_getClassList(NULL, 0);
    
    if (count <= 0) {
        return [NSArray array];
    }
    
    NSMutableArray *output = [NSMutableArray arrayWithObject:defaultClass];
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; i ++) {
        if (defaultClass == class_getSuperclass(classes[i])) {
            [output addObject:classes[i]];
        }
    }
    free(classes);
    
    return output;
    
}

@end
