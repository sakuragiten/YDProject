//
//  YDRegularViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/25.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDRegularViewController.h"

@interface YDRegularViewController ()

@end

@implementation YDRegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *url = @"https://im0001-test.oss-accelerate.aliyuncs.com/image/523860385573511169/1611200165172/46bj87mbbnr4/0293f3a3645e274c293af240f2ca09be_w828_h1104.png";
    NSString *regString = @"_wqw[1-9]+";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regString options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches = [regex matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    
    for (NSTextCheckingResult *item in matches) {
        NSLog(@"%@", [url substringWithRange:item.range]);
    }
    
}

@end
