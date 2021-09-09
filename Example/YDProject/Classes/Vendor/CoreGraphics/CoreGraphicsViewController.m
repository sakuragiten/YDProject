//
//  CoreGraphicsViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/18.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "CoreGraphicsViewController.h"

@interface CoreGraphicsViewController ()

@end

@implementation CoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *text = @"1???";
    NSString *text2 = @"2？？？";
    NSLog(@"%@", [text substringToIndex:1]);
    NSLog(@"%.2f-----%.2f", text.doubleValue, text2.doubleValue);
}

- (TestViewModelType)getDataType
{
    return TestViewModelTypeCoreGraphics;
}

@end
