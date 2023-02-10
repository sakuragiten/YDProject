//
//  RACMutableArrayController.m
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/7.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "RACMutableArrayController.h"
#import "NSMutableArray+RAC.h"
#import "RACManager.h"

@interface RACMutableArrayController ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation RACMutableArrayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", [RACManager shared].array);
    [self setupView];
    self.array = [NSMutableArray array];
    [RACManager shared].array = self.array;
    [self setupBindings];
    NSLog(@"%@", [RACManager shared].array);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    id obj = [NSString stringWithFormat:@"%ld", self.array.count];
//    [self.array addObject:obj];
//    [self.array addObjectsFromArray:@[obj]];
    [self.array insertObject:obj atIndex:0];
    NSLog(@"--------");
}


- (void)setupBindings {
    [self.array.rac_elementSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(20, 100, 100, 40);
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clickAction {
    if (self.array.count) {
        id obj = self.array.firstObject;
//        [self.array removeObject:obj];
//        [self.array removeAllObjects];
        [self.array removeLastObject];
    }
}

@end
