//
//  YDVideoTestController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "YDVideoTestController.h"

@interface YDVideoTestController ()

@property (nonatomic, strong) RACReplaySubject *r_subject;



@end

@implementation YDVideoTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addTestBtn];
    
    [self setupUI];
    
    RACReplaySubject *r_subject = [RACReplaySubject replaySubjectWithCapacity:1];
    [r_subject sendNext:@"1"];
    [r_subject sendNext:@"2"];
    
    [r_subject subscribeNext:^(id x) {
        NSLog(@"RACReplaySubject : %@", x);
    }];
    
    _r_subject = r_subject;
    
    RACSubject *subject = [RACSubject subject];
    [subject sendNext:@"A"];
    [subject sendNext:@"B"];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"RACSubject : %@", x);
    }];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    NSLog(@"dateString : %@", dateString);
    
    
    NSDateFormatter *day_formatter = [[NSDateFormatter alloc] init];
    [day_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dayString = [day_formatter stringFromDate:date];
    
    NSString *begin_dayString = [dayString stringByAppendingString:@" 00:00:00"];
    NSLog(@"start time of today : %@", begin_dayString);
    
    NSDate *begin_dateToday = [formatter dateFromString:begin_dayString];
    NSTimeInterval begin_timeintervalToday = [begin_dateToday timeIntervalSince1970];
    
    NSTimeInterval begin_timeintervalYesterday = begin_timeintervalToday - 24 * 3600;
    NSDate *yesterDay = [NSDate dateWithTimeIntervalSince1970:begin_timeintervalYesterday];
    NSString *yesterDayString = [formatter stringFromDate:yesterDay];
    
    NSLog(@"start time of yesterday : %@", yesterDayString);
    
    
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [s4 sendNext:@"4"];
//    });
    

    
    
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
    [_r_subject subscribeNext:^(id x) {
        NSLog(@"my: %@", x);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
