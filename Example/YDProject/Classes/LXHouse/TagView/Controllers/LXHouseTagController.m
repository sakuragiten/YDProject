//
//  LXHouseTagController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXHouseTagController.h"
#import "LXHouseTagView.h"


@interface LXHouseTagController ()

@property(nonatomic, strong) LXHouseTagView *tagView;

@property(nonatomic, strong) UIView *testView;



@end

@implementation LXHouseTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor randomColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    LXHouseTagView *tagView = [LXHouseTagView new];
    tagView.backgroundColor = [UIColor cyanColor];
    tagView.maxNumberOfLines = 1;
    [tagView reloadTagView:@[@"托尔斯泰", @"tdsfsdfs", @"电费水费", @"打得过大公鸡分公司", @"d", @"dgsdfhggksdkfg", @"特卖", @"严选", @"停售", @"即将开盘", @"商业", @"在售", @"售罄", @"待售"] heightRefresh:^(CGFloat height) {
//        [tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height);
//        }];
        CGRect frame = tagView.frame;
        frame.size.height = height;
        tagView.frame = frame;
    }];
    tagView.frame = CGRectMake(20, 100, 260, 80);
    
    [self.view addSubview:tagView];
    
//    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.top.mas_equalTo(100);
//        make.size.mas_equalTo(CGSizeMake(260, 80));
//    }];
    
    _tagView = tagView;
    
    [self addTestBtn];
    
    
    UIView *testView = [UIView new];
    testView.backgroundColor = [UIColor randomColor];
    [self.view addSubview:testView];
    _testView = testView;
    
    UIView *subTestView = [UIView new];
    subTestView.backgroundColor = [UIColor randomColor];
    [testView addSubview:subTestView];
    
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(200);
        make.size.mas_equalTo(CGSizeMake(260, 80));
    }];
    
    [subTestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)addTestBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor randomColor];
    btn.frame = CGRectMake(40, 40, 70, 35);
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)testAction
{
    SliderSheetController *vc = [SliderSheetController sliderWithTitle:@"ChangeTagViewFrame" actionNames:@[@"width", @"height"]];
    CGSize originalSize = self.tagView.frame.size;
//    __block CGRect frame = self.tagView.frame;
    __weak typeof(self) weakSelf = self;
    vc.sliderProgress = ^(NSInteger index, CGFloat value) {
        CGRect frame = weakSelf.tagView.frame;
        if (index == 0) {
            CGFloat w = originalSize.width + value * 100;
            frame.size.width = w;
        } else {
            CGFloat h = originalSize.height + value * 100;
            frame.size.height = h;
        }
        weakSelf.tagView.frame = frame;
        [weakSelf.tagView reloadData];
        
        frame.origin.y = 200;
        weakSelf.testView.frame = frame;
        
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}



@end
