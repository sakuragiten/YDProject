//
//  YDFontSession1ViewController.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/4/22.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDFontSession1ViewController.h"
#import "FontTestLabel.h"
#import "UIView+FontAdjust.h"
static CGFloat fontScale = 1.0;

@interface YDFontSession1ViewController ()

@property (nonatomic, strong) FontTestLabel *label1;

@property (nonatomic, strong) UILabel *label2;

@end




@implementation YDFontSession1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *first = [UIView new];
    first.backgroundColor = [UIColor randomColor];
//    first.frame = CGRectMake(50, 100, 300, 200);
    [self.view addSubview:first];
    
    _label1 = [FontTestLabel new];
    _label1.textColor = [UIColor whiteColor];
    _label1.text = @"这是一条测试数据，测试数据能说明什么，测试数据什么也说明不了";
//    _label1.frame = CGRectMake(10, 10, 200, 40);
    _label1.font = [UIFont systemFontOfSize:12];
    _label1.backgroundColor = [UIColor randomColor];
    _label1.numberOfLines = 0;
    [first addSubview:_label1];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(-20);
    }];
    
//    @weakify(self)
//    first.sx_fontAdjustSizeHandle = ^CGSize{
//        @strongify(self)
//        return CGSizeMake(300, self.label1.frame.size.height + 160);
//    };
    
    UILabel *label2 = [UILabel new];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"这是第二条测试数据，测试数据能说明什么，测试数据什么也说明不了";
    label2.font = [UIFont systemFontOfSize:12];
    label2.backgroundColor = [UIColor randomColor];
    label2.numberOfLines = 0;
    [first addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(10);
        make.left.equalTo(self.label1.mas_left);
        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo(label2.sx_fontAdjustSize.height);
        make.bottom.mas_equalTo(-10);
    }];
//    label2.frame = CGRectMake(10, 80, 200, 40);
    self.label2 = label2;
    
    [first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(100);
        make.width.mas_equalTo(300);
    }];
    
    [self addTestBtn];
    
}


- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor randomColor];
    btn.frame = CGRectMake(40, kScreenHeight - 100, 70, 35);
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    SliderSheetController *vc = [SliderSheetController sliderWithTitle:@"fontChanged" actionNames:@[@"font"]];
    @weakify(self)
    vc.sliderProgress = ^(NSInteger index, CGFloat value) {
        @strongify(self)
        // 0.5 ~ 1.5
        fontScale = value + 0.5;
        self.label1.font = [UIFont systemFontOfSize:24 * fontScale];
        self.label2.font = [UIFont systemFontOfSize:24 * fontScale];
//        [self.label1 sx_fontDidChanged];
//        [self.label2 sx_fontDidChanged];
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}



@end
