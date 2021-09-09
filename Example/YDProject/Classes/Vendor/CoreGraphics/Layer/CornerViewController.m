//
//  CornerViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/19.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "CornerViewController.h"

@interface CornerViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;

@end

@implementation CornerViewController


- (instancetype)init
{
    return [[CornerViewController alloc] initWithNibName:@"CornerViewController" bundle:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}



- (IBAction)testAction:(id)sender {
    
//    SliderSheetController *vc = [SliderSheetController sliderWithTitle:@"change frame" actionNames:@[@"width", @"height"]] ;
    SliderSheetController *vc = [SliderSheetController new];
    SliderAction *widthAction = [[SliderAction alloc] initWithTitle:@"width" maxValue:200.0 minValue:0.0];
    SliderAction *heightAction = [[SliderAction alloc] initWithTitle:@"height" maxValue:100.0 minValue:0.0];
    SliderAction *cornerAction = [[SliderAction alloc] initWithTitle:@"Radius" maxValue:20.0 minValue:0.0];
    [vc addActionWithAction:widthAction];
    [vc addActionWithAction:heightAction];
    [vc addActionWithAction:cornerAction];
    
    vc.sliderTitle = @"change frame";
    [self presentViewController:vc animated:YES completion:nil];

    
    CGSize originalSize = self.testView.frame.size;
    __block CGRect frame = self.testView.frame;
    __weak typeof(self) weakSelf = self;
    vc.sliderProgress = ^(NSInteger index, CGFloat value) {
        if (index == 0) {
            CGFloat w = originalSize.width + value;
            frame.size.width = w;
        } else if (index == 1) {
            CGFloat h = originalSize.height + value;
            frame.size.height = h;
        } else if (index == 2) {
            weakSelf.testView.cornerRadius = value;
        }
        weakSelf.testView.frame = frame;
    };
    
}



@end
