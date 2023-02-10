//
//  RACZipViewController.m
//  YDProject_Example
//
//  Created by 热心市民小龚 on 2023/2/8.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "RACZipViewController.h"


@interface RACZipViewController ()

@property (nonatomic, strong) RACSubject *subject1;

@property (nonatomic, strong) RACSubject *subject2;

@property (nonatomic, assign) NSInteger s1;
@property (nonatomic, assign) NSInteger s2;

@end

@implementation RACZipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
    
    
    _subject1 = [RACSubject subject];
    _subject2 = [RACSubject subject];
    
    RACSignal *signal = [_subject1 zipWith:_subject2];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_subject1 sendNext:[NSString stringWithFormat:@"signal 1 : %ld", _s1 ++]];
}

- (void)setupView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(20, 100, 100, 40);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)clickAction {
    
    [_subject2 sendNext:[NSString stringWithFormat:@"signal 2: %ld", _s2 ++]];
    
}

@end
