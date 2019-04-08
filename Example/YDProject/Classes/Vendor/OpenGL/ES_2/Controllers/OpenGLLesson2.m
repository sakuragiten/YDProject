//
//  OpenGLLesson2.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//


/** shader编译
 *  c语言编译流程：预编译、编译、汇编、链接
 *  glsl的编译过程类似c语言，主要有glCompileShader、glAttachShader、glLinkProgram三步；
 */

#import "OpenGLLesson2.h"
#import "OGLesson2View.h"

@interface OpenGLLesson2 ()



@end

@implementation OpenGLLesson2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OGLesson2View *lessonView = [OGLesson2View new];
    [self.view addSubview:lessonView];
    [lessonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}







@end
