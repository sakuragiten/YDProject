//
//  YDApplicationManager.h
//  YDProject
//
//  Created by louxunmac on 2019/4/17.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface YDApplicationManager : NSObject


+ (instancetype)sharedManager;

@property(nonatomic, strong) YDFPS *fps;


@end

NS_ASSUME_NONNULL_END
