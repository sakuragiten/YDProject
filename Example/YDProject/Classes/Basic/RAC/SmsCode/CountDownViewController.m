//
//  CountDownViewController.m
//  YDProject_Example
//
//  Created by 热心市民小龚 on 2023/2/8.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupBindings];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)setupBindings {
    
    RACSignal *enableSignal = [self.textField.rac_textSignal map:^id(NSString *value) {
        return [NSNumber numberWithBool:value.length == 11];
    }];
    
    
    RACSignal *(^countSignal)(NSNumber *count) = ^RACSignal * (NSNumber *count) {
        
        RACSignal *timeSignal = [RACSignal interval:1 onScheduler:RACScheduler.mainThreadScheduler];
        
        RACSignal *countSignal = [[timeSignal scanWithStart:count reduce:^id(NSNumber *running, id next) {
            return @(running.integerValue - 1);
        }] takeUntilBlock:^BOOL(NSNumber *value) {
            return value.integerValue < 0;
        }];
        
        return [countSignal startWith:count];
    };
    
    
    RACCommand *command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
        return countSignal(@10);
    }];
    
    RACSignal *countStringSignal = [[command.executionSignals switchToLatest] map:^id(NSNumber *value) {
        return [NSString stringWithFormat:@"%@s后重新获取", value];
    }];
    
    RACSignal *restStringSignal = [[command.executing filter:^BOOL(NSNumber *value) {
        return ![value boolValue];
    }] mapReplace:@"点击获取验证码"];
    
    [self.codeBtn rac_liftSelector:@selector(setTitle:forState:)
                       withSignals:[RACSignal merge:@[countStringSignal, restStringSignal]], [RACSignal return:@(UIControlStateNormal)], nil];
    self.codeBtn.rac_command = command;
}


@end
