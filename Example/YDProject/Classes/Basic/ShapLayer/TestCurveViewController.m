//
//  TestCurveViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/12/7.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "TestCurveViewController.h"
#import "YDCurveView.h"

@interface TestCurveViewController ()

@property (nonatomic, strong) YDCurveView *curveView;

@end

@implementation TestCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self makeCurveView];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesDown)];
    
    [self.view addGestureRecognizer:tapGes];
}


#pragma mark - 作图表
-(void)makeCurveView{
    
    UIImage *image = [UIImage imageNamed:@"curveLine.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CGFloat height = image.size.height * kScreenWidth / image.size.width;
    CGRect frame = CGRectMake(0, 100, kScreenWidth, height);
    imageView.frame = frame;
    [self.view addSubview:imageView];
    
    _curveView = [[YDCurveView alloc] initWithFrame:frame];
    _curveView.backgroundColor = [UIColor clearColor];

    
    [self.view addSubview:_curveView];
    
    [_curveView refreshChartAnmition];
//    NSArray *pathX = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
//    NSArray *pathY = @[@"19",@"27",@"8",@"38",@"30",@"45",@"40",@"48",@"22",@"7"];
    
//    NSArray *pathX = @[@"10", @"9.5", @"9.0", @"8.5", @"8", @"7.5", @"7.2", @"6.9", @"6.7", @"6.5", @"6.2", @"6.0", @"5.5", @"5.0",  @"4.5", @"4", @"3.5", @"3.0",  @"2.5", @"2", @"1.5", @"1"];
//    NSArray *pathY = @[@"20", @"20", @"19.0", @"22", @"18", @"26", @"13.0", @"6.0", @"12.0", @"24", @"36", @"40", @"1", @"48.0", @"12.0", @"30.0", @"17", @"23.0", @"19", @"20.0", @"20", @"20"];
    
    NSArray *pathX = @[@"245.0", @"233.0", @"222.5", @"216.5", @"207.0", @"205.0", @"202.0", @"200.5", @"196.0", @"192.5",
                       @"190.0", @"187.0", @"183.5", @"182.0", @"178.0", @"174.5", @"172.0", @"168.5", @"165.0", @"164.5",
                       @"158.0", @"156.0", @"155.0", @"150.0", @"140.0", @"133.0", @"123.0", @"117.0"];
    NSArray *pathY = @[@"113.0", @"112.5", @"111.5", @"119.5", @"107.6", @"125.0", @"123.0", @"109.0", @"91.00", @"94.00",
                       @"137.0", @"146.0", @"137.0", @"92.00", @"82.00", @"94.00", @"146.0", @"156.0", @"139.0", @"106.0",
                       @"95.00", @"102.0", @"132.0", @"134.0", @"114.0", @"110.0", @"116.0", @"108.0"];
    
    [_curveView drawSmoothViewWithArrayX:pathX andArrayY:pathY andScaleX:1.0];

    
}

-(void)tapGesDown{

    [_curveView refreshChartAnmition];
        
}


@end
