//
//  LXMainViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXMainViewController.h"

@implementation LXMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestModel *model = self.viewModel.dataArray[indexPath.row];
    
    Class vcClass = NSClassFromString(model.className);
    UIViewController *vc = [[vcClass alloc] init];
    vc.title = model.title;
    
    if (indexPath.row == 1) {
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (TestViewModelType)getDataType
{
    return TestViewModelTypeLXHouse;
}


@end
