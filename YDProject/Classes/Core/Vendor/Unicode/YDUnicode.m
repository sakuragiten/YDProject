//
//  YDUnicode.m
//  YDProject
//
//  Created by gongsheng on 2018/6/12.
//

#import "YDUnicode.h"

#import <objc/runtime.h>



static inline void yd_swizzleSelector(Class class, SEL originalSelector, SEL targetSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method targetMethod = class_getInstanceMethod(class, targetSelector);
    
    if (class_addMethod(class, originalSelector, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod))) {
        class_replaceMethod(class, targetSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, targetMethod);
    }
}



@implementation NSString (yd_unicode)


- (NSString *)yd_stringByReplacingUnicode
{
    NSMutableString *convertedString = [self mutableCopy];
    
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

@end



@implementation NSArray (yd_unicode)

+ (void)load
{
    Class class = [self class];
    yd_swizzleSelector(class, @selector(description), @selector(yd_description));
    yd_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(yd_descriptionWithLocale:));
    yd_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(yd_descriptionWithLocale:indent:));
}



- (NSString *)yd_description
{
    return [[self yd_description] yd_stringByReplacingUnicode];
}


- (NSString *)yd_descriptionWithLocale:(id)locale
{
    return [[self yd_descriptionWithLocale:locale] yd_stringByReplacingUnicode];
}

- (NSString *)yd_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [[self yd_descriptionWithLocale:locale indent:level] yd_stringByReplacingUnicode];
}

@end



@implementation NSDictionary (yd_unicode)

+ (void)load
{
    Class class = [self class];
    yd_swizzleSelector(class, @selector(description), @selector(yd_description));
    yd_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(yd_descriptionWithLocale:));
    yd_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(yd_descriptionWithLocale:indent:));
}


- (NSString *)yd_description
{
    return [[self yd_description] yd_stringByReplacingUnicode];
}


- (NSString *)yd_descriptionWithLocale:(id)locale
{
    return [[self yd_descriptionWithLocale:locale] yd_stringByReplacingUnicode];
}

- (NSString *)yd_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [[self yd_descriptionWithLocale:locale indent:level] yd_stringByReplacingUnicode];
}

@end



@implementation NSSet (yd_unicode)

+ (void)load
{
    Class class = [self class];
    yd_swizzleSelector(class, @selector(description), @selector(yd_description));
    yd_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(yd_descriptionWithLocale:));
    yd_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(yd_descriptionWithLocale:indent:));
}


- (NSString *)yd_description
{
    return [[self yd_description] yd_stringByReplacingUnicode];
}


- (NSString *)yd_descriptionWithLocale:(id)locale
{
    return [[self yd_descriptionWithLocale:locale] yd_stringByReplacingUnicode];
}

- (NSString *)yd_descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    return [[self yd_descriptionWithLocale:locale indent:level] yd_stringByReplacingUnicode];
}

@end
















