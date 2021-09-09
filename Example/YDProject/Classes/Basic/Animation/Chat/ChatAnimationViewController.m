//
//  ChatAnimationViewController.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/6/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "ChatAnimationViewController.h"
#import "ChatAnimationCell.h"

@interface ChatAnimationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ChatAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.tableView registerClass:[ChatAnimationCell class] forCellReuseIdentifier:@"ChatAnimationCell"];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:0 target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    

    _dataArray = [NSMutableArray array];
}

- (void)rightAction
{
    NSInteger type = arc4random() % 2;
    ChatModel *model = [ChatModel new];
    model.content = type ? @"第一条消息, I am fine" : @"第二条消息， thank you and you ";
    model.showAnimation = YES;
    [_dataArray addObject:model];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatAnimationCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.separatorStyle = UITableViewScrollPositionNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
    }
    
    return _tableView;
}


@end
