//
//  LXImageCutViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/26.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXImageCutViewController.h"

@interface LXImageCutViewController ()

@property(nonatomic, strong) UIImageView *testImageView;


@property(nonatomic, strong) UIWindow *window;


@end

@implementation LXImageCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}


- (void)setupUI
{
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor randomColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bajie"]];
    [self.view addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meizi"]];
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    imageView.frame = frame;
    [self.view addSubview:imageView];
    
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = CGRectMake(30, 30, 80, 80);
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(30, 30, 90, 90)];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, frame.size.height - 300, frame.size.width, 300)];
    layer.path = path.CGPath;
    layer.lineWidth = 3.0;
    imageView.layer.mask = layer;
    
    _testImageView = imageView;
    
    @weakify(self)
    [[self rac_signalForSelector:@selector(viewDidLayoutSubviews)] subscribeNext:^(id x) {
        @strongify(self)
        self.testImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height);
    }];
    
    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    UIViewController *vc = [UIViewController new];
//    vc.view.backgroundColor = [UIColor orangeColor];
//    window.rootViewController = vc;
//    window.windowLevel = UIWindowLevelStatusBar + 1;
//    window.hidden = NO;
//    window.alpha = 1;
//
//    _window = window;
}

- (void)viewDidLayoutSubviews
{
    
}


@end
