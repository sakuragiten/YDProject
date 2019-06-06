//
//  DebugViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/28.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "DebugViewController.h"

@interface DebugViewController ()

@end

@implementation DebugViewController


#ifdef DEBUG

#define hd_errorMsg(msg) [NSString stringWithFormat:@"%@", msg]

#else

#define hd_errorMsg(msg) [NSString stringWithFormat:@"%@", @"暂无数据"]

#endif




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSLog(@"%@", hd_errorMsg(@"hd_errosMsg"));
    
}






@end
