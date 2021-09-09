//
//  SettingViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "SettingViewController.h"
#import "SwitchButtonCell.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self setupUI];
}


- (void)setupUI
{
    self.title = @"Setting";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    
    [self layout];
}

- (void)layout
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (nonnull __kindof UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwitchButtonCell *cell = [SwitchButtonCell cellFromeXibWithTableView:tableView];
    cell.title = @"FPS";
    cell.switchON = ![YDApplicationManager sharedManager].fps.isHidden;
    cell.switchHandle = ^(UISwitch * _Nonnull sender) {
        [YDApplicationManager sharedManager].fps.hidden = !sender.isOn;
    };
    return cell;
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

#pragma mark - lazyload
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


@end
