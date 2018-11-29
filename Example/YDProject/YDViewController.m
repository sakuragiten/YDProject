//
//  YDViewController.m
//  YDProject
//
//  Created by 387970107@qq.com on 04/18/2018.
//  Copyright (c) 2018 387970107@qq.com. All rights reserved.
//

#import "YDViewController.h"
#import <YDProject/YDPoject.h>
#import "YDTest.h"
#import <objc/runtime.h>



#import "YDProject_Example-Swift.h"
//#import <YDProject/YDProject-Swift.h>
@interface YDViewController ()

@end

@implementation YDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor randomColor];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
   
    

//    [btn titleForState:UIControlStateNormal];
    
//    YDMap *map = [YDMap new];
    
    /*
     https://testapi.mediportal.com.cn/online-marketing/mobil/promotion/getPromotionDetail/5be23e9c04dd3c07e8daa39a?access_token=9d7692dba4ad4029953ee2a14be26708 
     */
    
    
    SEL selector = @selector(sayHelloWord);
    Method m = class_getInstanceMethod([self class], selector);
    IMP imp = class_getMethodImplementation([self class], selector);
    class_addMethod([YDTest class], selector, imp, method_getTypeEncoding(m));
}




- (void)testAction
{
//    YDMap *map = [YDMap new];
//    [map setObject:@"Viktor Kong" forkey:@"test"];
//    map[@"key"] = @"Edison";
//    map[@"key"] = @"Einstein";
//    NSLog(@"%@", map[0]);
//    NSLog(@"%ld", map.allKeys.count);
//    NSLog(@"%@", map.allKeys.lastObject);
//    NSLog(@"%@", map.allValues.lastObject);
//    NSLog(@"%@", map.allValues.lastObject);
//
//    map[@"key"] = nil;
    
//    [self testAddMethod];
    NSLog(@"0000000");
    
    
}

- (void)testAddMethod
{
    YDTest *test = [YDTest new];
    
    SEL selector = NSSelectorFromString(@"sayHelloWord");
    [test performSelector:selector];
}



- (void)sayHelloWord
{
    NSLog(@"Hello World");
}


- (void)parseAction
{
//    NSString *json = @"iOS中的json字符串";
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json_parse" ofType:@"js"];
//    NSString *js = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    // 使用 JSContext 加载 JS 文件
//    [self.context evaluateScript:js withSourceURL:[NSURL URLWithString:@"json_parse.js"]];
//    // 调用 parseJson 方法
//    JSValue *parseJsonResultValue = [self.context[@"parseJson"] callWithArguments:@[json]];
//    // 调用 renderJson 方法
//    JSValue *renderJsonResultValue = [self.context[@"renderJson"] callWithArguments:@[[parseJsonResultValue toObject] ?: @""]];
//    // renderJson 就是我们最终要显示的字符串
//    NSString *renderJson = [renderJsonResultValue toString];
}



@end
