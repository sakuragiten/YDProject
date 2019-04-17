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
    tagView.frame = CGRectMake(20, 100, 260, 80);
    
    [self.view addSubview:tagView];
    
    _tagView = tagView;
    
    [self addTestBtn];
    
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
    __block CGRect frame = self.tagView.frame;
    __weak typeof(self) weakSelf = self;
    vc.sliderProgress = ^(NSInteger index, CGFloat value) {
        if (index == 0) {
            CGFloat w = originalSize.width + value * 100;
            frame.size.width = w;
        } else {
            CGFloat h = originalSize.height + value * 100;
            frame.size.height = h;
        }
        weakSelf.tagView.frame = frame;
        [weakSelf.tagView reloadData];
        
    };
    [self presentViewController:vc animated:YES completion:nil];
    
}



@end
