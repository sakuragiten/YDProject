//
//  LXGraphicsController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/15.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXGraphicsController.h"
#import "UIView+LXExtension.h"

@interface LXGraphicsController ()

@end

@implementation LXGraphicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"lable frame";
        label.frame = CGRectMake(30, 30, kScreenWidth - 60, 50);
        [self.view addSubview:label];
        [label lx_settingGradientLayer];
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17];
        label.text = @"label autoLayout";
        [label lx_settingGradientLayer];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(100);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(50);
        }];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"here is button, tap to hide" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(30, 170, kScreenWidth - 60, 50);
        [btn lx_settingGradientLayer];
        [self.view addSubview:btn];
        @weakify(btn)
        btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(btn)
            btn.hidden = YES;
            return [RACSignal empty];
        }];
    }
    
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"button with image and title" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"yao.jpg"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(30, 240, kScreenWidth - 60, 50);
        [btn lx_settingGradientLayer];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"button with corner radius" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(30, 310, kScreenWidth - 60, 50);
        [btn lx_settingGradientLayer:^(CAGradientLayer * _Nonnull layer) {
            layer.cornerRadius = 10.0;
        }];
        [self.view addSubview:btn];
    }
    
    
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"lable from orange to green";
        label.frame = CGRectMake(30, 380, kScreenWidth - 60, 50);
        [self.view addSubview:label];
        [label lx_settingGradientLayer:^(CAGradientLayer * _Nonnull layer) {
            layer.colors = @[(__bridge id)[UIColor orangeColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
            layer.cornerRadius = 10.0;
        }];
    }
    
}


- (void)dealloc
{
    NSLog(@"%s", __func__);
}


@end
