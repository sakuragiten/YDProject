//
//  TestMainViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/8.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import "TestMainViewController.h"
#import "SettingViewController.h"

@interface TestMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;





@end

@implementation TestMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    
//    NSLog(@"10 / 0 = %d", (10 / 0));
//    NSArray *test = @[];
//    NSLog(@"%@", test.firstObject);
//    NSInteger a = 1;
//    NSMutableArray *result = [NSMutableArray array];
//    while (a < 100000000) {
//        UIImage *image = [UIImage imageNamed:@"for_test"];
//        [result addObject:image];
//        a ++;
//    }
    
    
    
    
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    rightItem.tintColor = [UIColor darkGrayColor];
//    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightAction
{
    SettingViewController *vc = [[SettingViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
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
