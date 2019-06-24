//
//  NSString+Extension.m
//  YDProject
//
//  Created by louxunmac on 2019/4/16.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)gs_decimalString
{
    double value = self.doubleValue;
    
    return [NSString gs_decimalStringFromeDoubleValue:value];
    
}

+ (NSString *)gs_decimalStringFromeDoubleValue:(double)value
{
    if (value == 0) return @"";
    
    int n = 2; //保留两位小数 如果小数部分为0 则忽略掉0
    int m = pow(10, n);
    
    
    NSInteger v = round( value * m);
    int i = n;
    while (i > 0 && v % 10 == 0) {
        v = v / 10;
        i --;
    }
    NSMutableString *decimalString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%ld", v]];
    if (i > 0) {
        [decimalString insertString:@"." atIndex:decimalString.length - i];
    }
    return decimalString;
}


@end


@implementation NSNumber (Extension)

- (NSString *)gs_decimalString
{
    double value = self.doubleValue;

    return [NSString gs_decimalStringFromeDoubleValue:value];
}

@end
