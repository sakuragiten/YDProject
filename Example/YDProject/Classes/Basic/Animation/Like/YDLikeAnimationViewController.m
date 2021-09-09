//
//  YDLikeAnimationViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2021/1/20.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDLikeAnimationViewController.h"
#import "YDLikeButton.h"
#import "YDVideoLikeButton.h"
#import "UIView+Animation.h"

@interface YDLikeAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) YDLikeButton *likeBtn;

@property (nonatomic, strong) YDVideoLikeButton *videoLikeBtn;


@end

@implementation YDLikeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _likeBtn = [YDLikeButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setImage:[[UIImage imageNamed:@"icon_dynamic_like_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_likeBtn setImage:[[UIImage imageNamed:@"icon_dynamic_like_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    _likeBtn.frame = CGRectMake(kScreenWidth * 0.5 - 50, 200, 100, 100);
    [self.view addSubview:self.likeBtn];
    
    _videoLikeBtn = [YDVideoLikeButton buttonWithType:UIButtonTypeCustom];
    [_videoLikeBtn setImage:[[UIImage imageNamed:@"icon_dynamic_like_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_videoLikeBtn setImage:[[UIImage imageNamed:@"icon_dynamic_like_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_videoLikeBtn addTarget:self action:@selector(videolLikeAction:) forControlEvents:UIControlEventTouchUpInside];
    _videoLikeBtn.frame = CGRectMake(kScreenWidth * 0.5 - 50, 350, 100, 100);
    [self.view addSubview:_videoLikeBtn];
    
    UIButton *another = [YDVideoLikeButton buttonWithType:UIButtonTypeCustom];
    [another setImage:[[UIImage imageNamed:@"icon_dynamic_like_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [another setImage:[[UIImage imageNamed:@"icon_dynamic_like_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [another addTarget:self action:@selector(videolLikeAction2:) forControlEvents:UIControlEventTouchUpInside];
    another.frame = CGRectMake(kScreenWidth * 0.5 - 50, 500, 100, 100);
    [self.view addSubview:another];
    
    
}

- (void)likeAction:(YDLikeButton *)btn
{
    btn.selected = !btn.isSelected;
    
    if (btn.isSelected) {
        [btn startAnimation];
    }
}


- (void)videolLikeAction:(YDVideoLikeButton *)btn
{
    btn.selected = !btn.isSelected;
    
    if (btn.isSelected) {
        [btn startAnimation];
    }
}

- (void)videolLikeAction2:(YDVideoLikeButton *)btn
{
    btn.selected = !btn.isSelected;
    
    if (btn.isSelected) {
        [btn startAnimation2];
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount < 2) return;
    CGPoint point = [touch locationInView:touch.view];
    
    [self.view showAnimationAtLocation:point];
}


- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
