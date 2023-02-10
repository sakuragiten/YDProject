//
//  RACDisposeNextController.m
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/3.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "RACDisposeNextController.h"
#import "DIsposeViewModel.h"
@interface RACDisposeNextController ()

@property (nonatomic, strong) DIsposeViewModel *viewModel;

@end

@implementation RACDisposeNextController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.viewModel.subject subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    RACDisposable *dispose = [[DIsposeViewModel shared].subject subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [self.rac_deallocDisposable addDisposable:dispose];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.viewModel.subject sendNext:@"new message"];
    
    [[DIsposeViewModel shared].subject sendNext:@"new message of shared"];
}

- (DIsposeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [DIsposeViewModel new];
    }
    return _viewModel;
}

@end
