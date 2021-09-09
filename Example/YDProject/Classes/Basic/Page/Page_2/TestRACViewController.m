//
//  TestRACViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/24.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "TestRACViewController.h"

@interface TestRACViewController ()

@property (nonatomic, strong) RACReplaySubject *subject;

@property (nonatomic, strong) RACCommand *command;



@end

@implementation TestRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
//    [self subjectTest];
//    [self testThrottle];
    [self testReplaySubjectAndThrottle];
    
    [self addTestBtn];
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
//    [self subjectTestAgain];
//    [self subjectTestLast];
    
    [self commadTest];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)testReplaySubjectAndThrottle
{
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    for (int i = 0; i < 5; i ++) {
        [subject sendNext:@(i)];
    }
    
    [[subject throttle:0.5] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
//    for (int i = 0; i < 10; i ++) {
//        [subject sendNext:@(i)];
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [subject sendNext:@"last"];
//    });
}


- (void)testThrottle
{
    RACSubject *subject = [RACSubject subject];
    
    [[subject throttle:0.5] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    for (int i = 0; i < 5; i ++) {
        [subject sendNext:@(i)];
    }
    [subject sendNext:@"1"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [subject sendNext:@"last"];
    });
    
}





- (void)subjectTest
{
//    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
//    _subject = subject;
//
//    [subject subscribeNext:^(id x) {
//        NSLog(@"main %@", x);
//    }];
    
    RACSubject *s = [RACSubject subject];
    RACSubject *s1 = [RACSubject subject];
    RACSubject *s2 = [RACSubject subject];
    RACSubject *s3 = [RACSubject subject];
    RACSubject *s4 = [RACSubject subject];

    [s.switchToLatest subscribeNext:^(id x) {
        NSLog(@"这是前半部分 subject = %@", x);
    }];
    
    
    [s sendNext:s1];
    [s sendNext:s2];
    [s sendNext:s3];
    
    [s3 sendNext:@"3"];
    [s1 sendNext:@"1"];
    [s2 sendNext:@"2"];
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [s sendNext:s4];
//        [s4 sendNext:@"4 again"];
//    });
    
    
    
    
//    [s sendNext:s4];
//    [s4 sendNext:@"4"];
    
//    [s.switchToLatest subscribeNext:^(id x) {
//        NSLog(@"这是后半部分 subject = %@", x);
////        [subject sendNext:x];
//    }];
    
//    [s1 sendNext:@"1"];
//    [s2 sendNext:@"2"];
//    [s3 sendNext:@"3"];
//
    
}



- (void)subjectTestAgain
{
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];


    
    [subject sendNext:@"again 1"];
    [subject sendNext:@"again 2"];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"again %@", x);
    }];

    
}


- (void)subjectTestLast
{
    RACSubject *subject = [RACSubject subject];
    
    RACSubject *s1 = [RACSubject subject];
    RACSubject *s2 = [RACSubject subject];

    
    [subject.switchToLatest subscribeNext:^(id x) {
        NSLog(@"这是前半部分 subject = %@", x);
    }];

    [subject sendNext:s1];
    [subject sendNext:s2];
    
    [s1 sendNext:@"last 1"];
    [s2 sendNext:@"last 2"];
    
    [subject.switchToLatest subscribeNext:^(id x) {
        NSLog(@"这是后半部分 subject = %@", x);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [s1 sendNext:@"last 两秒以后 1"];
        [s2 sendNext:@"last 两秒以后 2"];
    });
}


- (void)commadTest
{
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    [self.command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [self.command execute:@"1"];
    [self.command execute:@"2"];
    [self.command execute:@"A"];
    [self.command execute:@"B"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.command execute:@"C"];
        [self.command execute:@"3"];
        [self.command execute:@"4"];
    });
    
    
}





- (RACCommand *)command
{
    if (!_command) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            RACSubject *subject = [RACSubject subject];
            [subject sendNext:input];
            [subject sendCompleted];
            return subject;
        }];
    }
    
    return _command;
}


@end
