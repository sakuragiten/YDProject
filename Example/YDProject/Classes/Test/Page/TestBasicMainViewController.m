//
//  TestBasicMainViewController.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/3/1.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "TestBasicMainViewController.h"

@interface TestBasicMainViewController ()


//nullable,nonnull,null_resettable,null_unspecified
//@property (nonatomic, null_resettable, unsafe_unretained, getter=isName) NSString *name;

@property (nonatomic, copy) NSString *name;

//@dynamic name;

@end



@implementation TestBasicMainViewController

//@synthesize name = _name;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    YDTest *t = [YDTest new];
//    YDTest const *t1 = [YDTest new];
//    YDTest * const t2 = [YDTest new];
//
//
//    t1.name = @"123123";
//    t2 = t;
    
//    NSString const *name = @"gongsheng";
//    name = @"woqu";
//
//    const NSString *age = @"18";
//    age = @"23";
//
//    NSString * const sex = @"male";
////    sex = @"female";
//
//
//    NSLog(@"name:%@-%p", name, name);
//    NSLog(@"age:%@", age);
    
    
    
    NSArray *a = @[@"1", @"2", @"3"];
    NSArray *b = [NSArray mutableCopy];
//    [b removeLastObject];
    
    
    
//    NSLog(@"a = %ld, b = %ld", a.count, b.count);
//    NSLog(@"a[0]:%@, b[0]:%@", a[0], b[0]);
    NSLog(@"a:%@, B:%@", a, b);
    
    NSMutableArray *aa = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSMutableArray *bb = [aa copy];;
    
    [aa removeAllObjects];
    
    NSLog(@"aa = %ld, bb = %ld", aa.count, bb.count);
}





//
//- (void)setName:(NSString *)name
//{
//    _name = name;
//}
//
//- (NSString *)name
//{
//    return _name;
//}






- (TestViewModelType)getDataType
{
    return TestViewModelTypeCoreBasic;
}

@end
