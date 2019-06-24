//
//  DecimalStringViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/16.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "DecimalStringViewController.h"

@interface DecimalStringViewController ()

@end

@implementation DecimalStringViewController

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
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor randomColor];
        label.numberOfLines = 2;
        NSString *valueString = @"100.00000000000001";
        NSString *decimalString = valueString.gs_decimalString;
        label.text = [NSString stringWithFormat:@"origial value is:%@ \n decimal value is: %@", valueString, decimalString];
        label.frame = CGRectMake(30, 30, kScreenWidth - 60, 40);
        [self.view addSubview:label];
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor randomColor];
        label.numberOfLines = 2;
        NSString *valueString = @"0";
        NSString *decimalString = valueString.gs_decimalString;
        label.text = [NSString stringWithFormat:@"origial value is:%@ \n decimal value is: %@", valueString, decimalString];
        label.frame = CGRectMake(30, 90, kScreenWidth - 60, 40);
        [self.view addSubview:label];
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor randomColor];
        label.numberOfLines = 2;
        NSString *valueString = @"9.9999999";
        NSString *decimalString = valueString.gs_decimalString;
        label.text = [NSString stringWithFormat:@"origial value is:%@ \n decimal value is: %@", valueString, decimalString];
        label.frame = CGRectMake(30, 150, kScreenWidth - 60, 40);
        [self.view addSubview:label];
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor randomColor];
        label.numberOfLines = 2;
        NSString *valueString = @"1.234";
        NSString *decimalString = valueString.gs_decimalString;
        label.text = [NSString stringWithFormat:@"origial value is:%@ \n decimal value is: %@", valueString, decimalString];
        label.frame = CGRectMake(30, 210, kScreenWidth - 60, 40);
        [self.view addSubview:label];
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor randomColor];
        label.numberOfLines = 2;
        NSString *valueString = @"1.236";
        NSString *decimalString = valueString.gs_decimalString;
        label.text = [NSString stringWithFormat:@"origial value is:%@ \n decimal value is: %@", valueString, decimalString];
        label.frame = CGRectMake(30, 270, kScreenWidth - 60, 40);
        [self.view addSubview:label];
    }
}


@end
