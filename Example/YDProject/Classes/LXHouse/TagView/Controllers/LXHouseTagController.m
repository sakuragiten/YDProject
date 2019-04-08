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

@end

@implementation LXHouseTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    LXHouseTagView *tagView = [LXHouseTagView new];
    tagView.backgroundColor = [UIColor cyanColor];
    tagView.frame = CGRectMake(20, 80, 330, 80);
    
    [self.view addSubview:tagView];
}



@end
