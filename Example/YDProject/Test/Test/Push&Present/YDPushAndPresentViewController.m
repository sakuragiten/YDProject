//
//  YDPushAndPresentViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/2/25.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "YDPushAndPresentViewController.h"

@interface YDPushAndPresentViewController ()

@end

@implementation YDPushAndPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTestBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)addTestBtn
{
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"pushToViewControllerWithNavigation" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 100, screenWidth - 20, 40);
        btn.backgroundColor = [UIColor randomColor];
        [btn addTarget:self action:@selector(pushToViewControllerWithNavigation) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"pushToNavigationWithViewController(crash)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 200, screenWidth - 20, 40);
        btn.backgroundColor = [UIColor randomColor];
        [btn addTarget:self action:@selector(pushToNavigationWithViewController) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"presentToViewControllerWithNavigation(crash)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 300, screenWidth - 20, 40);
        btn.backgroundColor = [UIColor randomColor];
        [btn addTarget:self action:@selector(presentToViewControllerWithNavigation) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"presentToNavigationWithViewController" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 400, screenWidth - 20, 40);
        btn.backgroundColor = [UIColor randomColor];
        [btn addTarget:self action:@selector(presentToNavigationWithViewController) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"navPresentToViewControllerWithNavigation(crash)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 500, screenWidth - 20, 40);
        btn.backgroundColor = [UIColor randomColor];
        [btn addTarget:self action:@selector(navPresentToViewControllerWithNavigation) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"navPresentToNavigationWithViewController" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10, 600, screenWidth - 20, 40);
        btn.backgroundColor = [UIColor randomColor];
        [btn addTarget:self action:@selector(navPresentToNavigationWithViewController) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
}

- (void)pushToViewControllerWithNavigation
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor randomColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToNavigationWithViewController
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor randomColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.navigationController pushViewController:nav animated:YES];
}
- (void)presentToViewControllerWithNavigation
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor randomColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)presentToNavigationWithViewController
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor randomColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)navPresentToViewControllerWithNavigation
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor randomColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)navPresentToNavigationWithViewController
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor randomColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
