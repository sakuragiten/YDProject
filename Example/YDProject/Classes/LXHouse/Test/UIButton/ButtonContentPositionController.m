//
//  ButtonContentPositionController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/15.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "ButtonContentPositionController.h"
#import "UIView+LXExtension.h"

@interface ButtonContentPositionController ()

@end

@implementation ButtonContentPositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    discover_liked_selected
    [self setupUI];
    
    [self test];
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}


- (void)test
{
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.backgroundColor = [UIColor randomColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"discover_liked_selected"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(150, 40, 80, 80);
        
        [btn setTitle:@"top" forState:UIControlStateNormal];
        [btn lx_reloadContentWithStyle:LXButtonCoententImageTop];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.backgroundColor = [UIColor randomColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"discover_liked_selected"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(150, 140, 80, 80);
        
        [btn setTitle:@"left" forState:UIControlStateNormal];
        [btn lx_reloadContentWithStyle:LXButtonCoententImageLeft];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.backgroundColor = [UIColor randomColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"discover_liked_selected"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(150, 240, 80, 80);
        
        [btn setTitle:@"bottom" forState:UIControlStateNormal];
        [btn lx_reloadContentWithStyle:LXButtonCoententImageBottom];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.backgroundColor = [UIColor randomColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"discover_liked_selected"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(150, 340, 80, 80);
        
        [btn setTitle:@"right" forState:UIControlStateNormal];
        [btn lx_reloadContentWithStyle:LXButtonCoententImageRight];
        
        [self.view addSubview:btn];
    }
}

@end
