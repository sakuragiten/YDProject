//
//  YDApplicationManager.m
//  YDProject
//
//  Created by louxunmac on 2019/4/17.
//

#import "YDApplicationManager.h"

@interface YDApplicationManager ()



@end

@implementation YDApplicationManager

static YDApplicationManager *_manager;
+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [YDApplicationManager new];
    });
    
    return _manager;
}


#pragma mark - lzayload
- (YDFPS *)fps
{
    if (!_fps) {
        _fps = [YDFPS new];
    }
    
    return _fps;
}




@end
