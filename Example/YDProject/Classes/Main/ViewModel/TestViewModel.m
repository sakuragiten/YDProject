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
        case TestViewModelTypeCoreBasic:
            [self settingBasicDataSource];
            break;
        case TestViewModelTypeLXHouse:
            [self settingLXHouseDataSource];
            break;
        case TestViewModelTypeLXBroker:
            [self settingLXBrokerDataSource];
        default:
            break;
    }
}



#pragma mark - main
- (void)settingMainDataSource
{
    self.dataArray = @[Test(@"NetWork", @"TestNetWorkController"),
                       Test(@"Basic", @"TestBasicMainViewController"),
                       Test(@"LXHouse", @"LXMainViewController"),
                       Test(@"LXBroker-楼讯经纪", @"LXBrokerMainController"),
                       Test(@"OpenGL", @"OpengGLMainViewController"),
                       Test(@"CoreGraphics", @"CoreGraphicsViewController"),
                       Test(@"FloatingButton", @"TestFloatingController"),
                       Test(@"Block", @"BlockViewController"),
                       Test(@"Push&Present", @"YDPushAndPresentViewController"),
                       Test(@"CityList", @"YDCityController"),
                       Test(@"萌萌考试", @"ExamViewController"),];
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
    self.dataArray = @[Test(@"文本属性Attributes", @"AttributesController"),
                       Test(@"设置圆角CornerRadius", @"CornerViewController")];
}

#pragma mark - basic
- (void)settingBasicDataSource
{
    self.dataArray = @[Test(@"Thread", @"TestThreadController"),
                       Test(@"Designated Initializer", @"TestDesignatedInitializer"),

                       Test(@"DecimalString", @"DecimalStringViewController"),
                       Test(@"Debug", @"DebugViewController"),
                       Test(@"RAC", @"TestRACViewController"),
                       Test(@"多行字符串的声明", @"StringStatementController"),
                       Test(@"测试图片", @"TestImageViewController"),
                       Test(@"CAShapLayer", @"YDShapLayerController"),];
}


#pragma mark - LXHouse
- (void)settingLXHouseDataSource
{
    self.dataArray = @[Test(@"TagView", @"LXHouseTagController"),
                       Test(@"LeadPage", @"LXHouseLeadPage"),
                       Test(@"Graphics", @"LXGraphicsController"),
                       Test(@"ButtonContent", @"ButtonContentPositionController"),
                       Test(@"ImageCut", @"LXImageCutViewController"),
                       Test(@"Album", @"LXHouseAlbumController"),
                       Test(@"Networking", @"LXNetworkingController"),
                       Test(@"WebView", @"LXWebViewController"),
                       Test(@"SegueToLouxunApp", @"LXSegueToLouxunController"),];
}


#pragma mark - LXBroker
- (void)settingLXBrokerDataSource
{
    self.dataArray = @[Test(@"CardView", @"LXCardTestViewController"),
                       Test(@"Video", @"YDVideoTestController"),
                       Test(@"打码", @"LXMarkController"),
                       Test(@"百度地图", @"BaiduMapViewController"),];
}


@end

