//
//  TestViewModel.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "TestViewModel.h"

@implementation TestViewModel


- (instancetype)initWithViewModelType:(TestViewModelType)type
{
    if (self = [super init]) {
        [self configurationWithModelType:type];
    }
    return self;
}

- (void)configurationWithModelType:(TestViewModelType)type
{
    switch (type) {
        case TestViewModelTypeDefault:
            [self settingMainDataSource];
            break;
        case TestViewModelTypeOpenGL:
            [self settingOpengGLDataSource];
            break;
        default:
            break;
    }
}



#pragma mark - main
- (void)settingMainDataSource
{
    self.dataArray = @[Test(@"NetWork", @"TestNetWorkController"),
                       Test(@"OpenGL", @"OpengGLMainViewController"),
                       Test(@"仿微信悬浮按钮", @"TestFloatingController"),
                       Test(@"Thread", @"TestThreadController")];
}


#pragma mark - opengl
- (void)settingOpengGLDataSource
{
    self.dataArray = @[Test(@"简单的画一张图", @"OpengGLLesson1")];
}


@end
