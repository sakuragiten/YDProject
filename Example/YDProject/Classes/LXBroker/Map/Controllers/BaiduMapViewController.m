//
//  BaiduMapViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/8/23.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "BaiduMapViewController.h"

@interface BaiduMapViewController ()

@end

@implementation BaiduMapViewController

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
    
}

@end
