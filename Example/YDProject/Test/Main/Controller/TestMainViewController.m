//
//  TestMainViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/8.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import "TestMainViewController.h"

@interface TestMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TestMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *vcName = [NSString stringWithFormat:@"%@Controller", _dataArray[indexPath.row]];
    Class vcClass = NSClassFromString(vcName);
    UIViewController *vc = [[vcClass alloc] init];
    vc.title = _dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - lazyload
- (NSArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = @[@"TestNetWork", @"TestFloating"];
    }
    
    return _dataArray;
}

@end
