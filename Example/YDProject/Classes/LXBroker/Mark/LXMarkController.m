//
//  LXMarkController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/7/25.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXMarkController.h"
#import "LXMarkTableViewController.h"

@interface LXMarkController ()

@property (nonatomic, strong) UIView *testView;


@property (nonatomic, strong) UITableView *tableView;



@end

@implementation LXMarkController

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

    [self addTestBtn];
    
    
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor = [UIColor purpleColor];
    testView.frame = CGRectMake(20, 180, 300, 400);
    [self.view addSubview:testView];
    
    UILabel *label = [UILabel new];
    label.text = @"为什么不行";
    label.backgroundColor = [UIColor randomColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(10, 10, 100, 40);
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    
    [testView addSubview:label];
    
    _testView = testView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
}


- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(100, 60, 60, 60);
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    UIImage *image = [self.testView lx_renderImage];
//    CGSize viewSize = self.view.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(viewSize, NO, 0.0);
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}


- (void)rightAction
{
    LXMarkTableViewController *vc = [LXMarkTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)imageSaveFinished
{
    NSLog(@"已保存到相册");
}



@end
