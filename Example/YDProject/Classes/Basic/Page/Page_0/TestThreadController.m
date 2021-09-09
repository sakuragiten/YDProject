//
//  TestThreadController.m
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/30.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//




#import "TestThreadController.h"
@interface TestThreadController ()

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) YDTest *tObjc;
@property (nonatomic, copy) NSString *s2;
@property (nonatomic, strong) NSMutableString *s3;

@end

@implementation TestThreadController


//static UIView *view = [UIView new]; 静态变量  编译时分配 这样写编译会报错
static UIView *_view = nil;
static NSString *_str = @"tet";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self kvoTest];

}


//开启一个子线程
- (void)testAction
{
    [NSThread detachNewThreadSelector:@selector(threadOne) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(threadTwo) toTarget:self withObject:nil];
}

static int _count = 0;

- (void)threadOne {
    while (1) {
        NSLog(@"%@-->%d", [NSThread currentThread], _count++);
        if (_count > 50) break;
    }
}

- (void)threadTwo {
    while (1) {
        NSLog(@"%@-->%d", [NSThread currentThread], _count++);
        if (_count > 50) break;
    }
}

#pragma mark - KVO
/**
    利用运行时，生成一个对象的子类，并生成子类对象，并替换原来对象的isa指针
    并且重写了set方法
 */

- (void)kvoTest
{
    _tObjc = [YDTest new];
    _tObjc.name = @"name_old";
    
    _tObjc.person = [YDPerson new];
    _tObjc.person.age = 21;
    
    NSLog(@"before: %s", object_getClassName(_tObjc)); //YDTest
    /*[YDTest]*/
    NSLog(@"before: %@", [YDTool findSubClass:[_tObjc class]]);
    [_tObjc addObserver:self forKeyPath:@"person" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"after: %s", object_getClassName(_tObjc));   //NSKVONotifying_YDTest
    
    /*[YDTest,"NSKVONotifying_YDTest"]*/
    NSLog(@"after: %@", [YDTool findSubClass:[_tObjc class]]);
    _tObjc.name = @"name_new";
    
    
    
    _tObjc.person.age = 16;
    

    
    
    //手动触发kvo  -> 某些特定的业务场景下
//    [_tObjc willChangeValueForKey:@"name"];
//    _tObjc.name = @"name_new";
//    [_tObjc didChangeValueForKey:@"name"];
    
    
    
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@",change);
}



#pragma mark - 内存分区

/**
 ● 内存分5个区块
 ○ 栈区     局部b变量，参数
 ○ 堆区      程序员手动分配，释放也是程序员释放 ARC自动管理只需要防止循环引用就行
 ○ 全局区 （静态变量，全局变量）生命周期-> 编译时产生，app结束时释放
 ○ 常量区 （常量）生命周期-> 编译时产生，app结束时释放 定义常量应该在编译时候就赋值
 ○ 代码区
 */

- (void)memoryTest
{
    _tObjc = [YDTest new];
    _array = [NSArray new];
    
    
    //    [self testAction];
    
    int a = 10;
    int *a1 = &a;
    //0x7ffee8b9839c - 0x7ffee8b9839c - 0x7ffee8b98390
    NSLog(@"%p - %p - %p", &a, a1, &a1);
    
    //0x1076411f8 常量区
    NSLog(@"p01 = %p", @"test");
    
    //全局区 0x106800a78
    NSLog(@"p02 = %p", &_str);
    
    NSString *ss1 = @"fsdfsdf";
    NSString *ss2 = @"fsdfsdf";
    NSString *ss3 = @"fsdfsdf";
    NSString *ss4 = @"fsdfsdf";
    NSLog(@"p03 = %p", &ss1);
    NSLog(@"p03 = %p", &ss2);
    NSLog(@"p03 = %p", &ss3);
    NSLog(@"p03 = %p", &ss4);
    
    
    NSLog(@"***************************************");
    
    //0x7ffee118d388 栈
    NSString *s = @"test";
    NSLog(@"p02 = %p", &s);
    
    //0x7ffee118d380 栈
    NSMutableString *s1 = [NSMutableString stringWithString:@"test"];
    NSLog(@"p03 = %p", &s1);
    
    //0x7fa357428c30 堆
    _s2 = @"test";
    NSLog(@"p04 = %p", &_s2);
    
    //0x7fa357428c38 堆
    _s3 = [NSMutableString stringWithString:@"test"];
    NSLog(@"p05 = %p", &_s3);
    
    //成员变量 堆
    NSLog(@"p06 = %p", &_tObjc);
    
    //局部变量 栈
    YDTest *p_ttObjc = [YDTest new];
    NSLog(@"p07 = %p", &p_ttObjc);
    
    NSLog(@"==========================================");
    
    //成员变量
    NSLog(@"_tObjc = %p", _tObjc);
    
    //局部变量
    YDTest *ttObjc = [YDTest new];
    NSLog(@"ttObjc = %p", ttObjc);
    
    
    NSLog(@"_view = %p", _view); //0x0
    UIView *v = [UIView new];
    NSLog(@"v = %p", v);    //0x7fd31bf24d20
    _view = v;
    NSLog(@"_view = %p", _view); //0x7fd31bf24d20
    NSLog(@"_view：x = %p p = %p", &_view,_view); //0x107b17808 0x7fd31bf24d20
    NSLog(@"[UIView new] = %p", [UIView new]); //0x7fd31bf21ff0
    NSLog(@"test = %p", @"test");  //0x1094a8228
    NSLog(@"_tObjc = %p", _tObjc); //0x60000209cb70
    NSLog(@"_array = %p", _array); //0x6000012e40c0
    
//    if (1) {
//        NSException *exception = [NSException exceptionWithName:@"找类似的崩溃名" reason:@"找类似的原因" userInfo:nil];
//        [exception raise];
//    }
}


@end
