//
//  NSString+Extension.h
//  YDProject
//
//  Created by louxunmac on 2019/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/** 保留两位小数 去掉小数点后多余的0 */
- (nonnull NSString *)gs_decimalString;


+ (nonnull NSString *)gs_decimalStringFromeDoubleValue:(double)value;

@end



NS_ASSUME_NONNULL_END




@interface NSNumber (Extension)

/** --保留两位小数 去掉小数点后多余的0 */
- (nonnull NSString *)gs_decimalString;
//@property (nonatomic, copy) NSString *decimalString;

@end
