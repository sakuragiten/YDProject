//
//  TestImageViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/7/1.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "TestImageViewController.h"

@interface TestImageViewController ()

@end

@implementation TestImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self addTestBtn];
    

    
    
}



- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
//    imageView sd
    
}


- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(100, 100, 100, 100);
//    btn.titleLabel.font = UIFontRegularMake(10);
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    
}







@end
