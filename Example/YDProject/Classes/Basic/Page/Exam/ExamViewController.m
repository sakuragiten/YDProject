//
//  ExamViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/2/8.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "ExamViewController.h"
#import "ExamView.h"

#define kTotal 50
#define KScore 2

@interface ExamViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ExamView *examView;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) NSMutableArray *quetion;


@property (nonatomic, strong) NSMutableArray *errorArray;

@property (nonatomic, assign) NSInteger score;

@end

@implementation ExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self begin];
}




- (void)setupUI
{
    self.title = @"表内除法";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _examView = [ExamView examView];
//    _examView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.examView];
    
    [self.view addSubview:self.tableView];
    
    [_examView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(210);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.examView.mas_bottom);
    }];
    
    @weakify(self)
    _examView.btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           @strongify(self)
            if (self.examView.f3.text.length) {
                [self check];
                [self nextQuestion];
            }
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}


- (void)begin
{
    [self reset];
    [self nextQuestion];
}


- (void)reset
{
    ExamView *e = self.examView;
    
    e.f1.text = @"";
    e.f2.text = @"";
    e.f3.text = @"";
    
    e.score.text = @"得分:0";
    e.num.text = @"第1题";
    
    [e.btn setTitle:@"下一题" forState:UIControlStateNormal];
}



- (void)nextQuestion
{
    
    if (self.quetion.count == kTotal) return;
    
    ExamView *e = self.examView;
    
    NSInteger a = arc4random() % 81 + 1;
    NSInteger max_b = a < 9 ? a : 9;
    NSInteger b = arc4random() % max_b + 1;
    
    NSString *key = [NSString stringWithFormat:@"%ld_%ld", a, b];
    if (a % b != 0 || a / b > 9 || [self.quetion containsObject:key]) {
        [self nextQuestion];
        return;
    }
    
    e.f3.text = @"";
    
    
    NSString *s1 = [NSString stringWithFormat:@"%ld", a];
    NSString *s2 = [NSString stringWithFormat:@"%ld", b];
    
    e.f1.text = s1;
    e.f2.text = s2;
    
}




- (void)check
{
    if (self.quetion.count == kTotal) return;
    
    ExamView *e = self.examView;
    NSInteger a = e.f1.text.integerValue;
    NSInteger b = e.f2.text.integerValue;
    NSInteger c = e.f3.text.integerValue;
    
    NSString *key = [NSString stringWithFormat:@"%ld_%ld", a, b];
    NSString *value = [NSString stringWithFormat:@"%ld ÷ %ld = %ld,  正确答案 %ld", a, b, c, a / b];
    [self.quetion addObject:key];
    if (a == b * c) {
        _score += KScore;
    } else {
        [self.errorArray addObject:value];
        [self.tableView reloadData];
    }
    
    if (self.quetion.count == kTotal) {
        [e.btn setTitle:@"考试结束" forState:UIControlStateNormal];
    } else {
        e.num.text = [NSString stringWithFormat:@"第%ld题", self.quetion.count + 1];
    }
    
    e.score.text = [NSString stringWithFormat:@"得分:%ld", self.score];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.errorArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.textColor = [UIColor systemPinkColor];
    cell.textLabel.text = self.errorArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.examView endEditing:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.separatorStyle = UITableViewScrollPositionNone;
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}


- (NSMutableArray *)errorArray
{
    if (!_errorArray) {
        _errorArray = [NSMutableArray array];
    }
    return _errorArray;
}

- (NSMutableArray *)quetion
{
    if (!_quetion) {
        _quetion = [NSMutableArray array];
    }
    return _quetion;
}

@end
