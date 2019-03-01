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
        case TestViewModelTypeCoreGraphics:
            [self settingCoreGraphicsDataSource];
            break;
        default:
            break;
    }
}



#pragma mark - main
- (void)settingMainDataSource
{
    self.dataArray = @[Test(@"NetWork", @"TestNetWorkController"),
                       Test(@"Basic", @"TestBasicMainViewController"),
                       Test(@"OpenGL", @"OpengGLMainViewController"),
                       Test(@"CoreGraphics", @"CoreGraphicsViewController"),
                       Test(@"FloatingButton", @"TestFloatingController"),
                       Test(@"Block", @"BlockViewController"),
                       Test(@"Push&Present", @"YDPushAndPresentViewController")];
}


#pragma mark - opengl
- (void)settingOpengGLDataSource
{
    self.dataArray = @[Test(@"简单的画一张图", @"OpengGLLesson1"),
                       Test(@"shader编译链接、glsl入门和简单图形变换", @"OpenGLLesson2")];
}

#pragma mark - CoreGraphics
- (void)settingCoreGraphicsDataSource
{
    self.dataArray = @[Test(@"文本属性Attributes", @"AttributesController")];
}

#pragma mark - basic
- (void)settingBasicDataSource
{
    self.dataArray = @[Test(@"Thread", @"TestThreadController"),];
}


@end
