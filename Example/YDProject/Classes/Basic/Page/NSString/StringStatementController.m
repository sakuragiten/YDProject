//
//  StringStatementController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/6.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "StringStatementController.h"

#define gs_ml(str) @#str

@interface StringStatementController ()

@property(nonatomic, strong) UILabel *label;


@end

@implementation StringStatementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self statementForLinesString];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor randomColor];
    label.text = @"";
    label.numberOfLines = 0;
    label.frame = CGRectMake(30, 30, kScreenWidth - 60, kScreenHeight - 60 - 94);
    [self.view addSubview:label];
 
    
    _label = label;
}



- (void)statementForLinesString
{
    
    NSMutableString *content = [[NSMutableString alloc] initWithString:@""];
    
    {
        NSString *title = @"1.利用@""包裹起来\n";
        NSString *text = @"这是第一部分"
        @"这是第二部分";
        [content appendString:title];
        [content appendString:text];
    }
    
    {
        [content appendString:@"\n\n"];
        
        NSString *title = @"2.利用""包裹起来\n";
        NSString *text = @"这是第一部分"
        "这是第二部分"
        "这是第三部分";
        [content appendString:title];
        [content appendString:text];
    }
    
    {
        [content appendString:@"\n\n"];
        
        NSString *title = @"3.利用 \\ 包裹起来(有缩进)\n";
        NSString *text = @"这是第一部分\
        这是第二部分";
        [content appendString:title];
        [content appendString:text];
    }
    {
[content appendString:@"\n\n"];

NSString *title = @"4.利用 \\ 包裹起来(无缩进)\n";
NSString *text = @"这是第一部分\
这是第二部分";
[content appendString:title];
[content appendString:text];
    }
    
    {
        [content appendString:@"\n\n"];
        
        NSString *title = @"5.利用宏 #define gs_ml(str) @#str\n";
        NSString *text = [NSString stringWithFormat:gs_ml(这是第一部分
                                                          这是第二部分)];
        [content appendString:title];
        [content appendString:text];
    }
    
    
    _label.text = content;
}







@end
