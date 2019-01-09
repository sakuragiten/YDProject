//
//  TestMainViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/8.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import "TestMainViewController.h"


@interface TestMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) TestViewModel *viewModel;



@end

@implementation TestMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    TestModel *model = self.viewModel.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestModel *model = self.viewModel.dataArray[indexPath.row];
    
    Class vcClass = NSClassFromString(model.className);
    UIViewController *vc = [[vcClass alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - lazyload
- (TestViewModel *)viewModel
{
    if (!_viewModel) {
        
        _viewModel = [[TestViewModel alloc] initWithViewModelType:[self getDataType]];
    }
    
    return _viewModel;
}


- (TestViewModelType)getDataType
{
    return TestViewModelTypeDefault;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


@end
