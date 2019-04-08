//
//  OpengGLLesson1.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/9.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "OpengGLLesson1.h"

@interface OpengGLLesson1 ()

@property (nonatomic, strong) EAGLContext *mContext;

@property (nonatomic, strong) GLKBaseEffect *mEffect;

@end

@implementation OpengGLLesson1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupConfig];
    [self uploadVertetArray];
    [self uploadTexture];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupConfig
{
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = (GLKView *)self.view;
    view.context = self.mContext;
    //颜色缓冲区格式
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
}




/**
 *  顶点数组里包括顶点坐标，OpenGLES的世界坐标系是[-1, 1]，故而点(0, 0)是在屏幕的正中间。
 *  纹理坐标系的取值范围是[0, 1]，原点是在左下角。故而点(0, 0)在左下角，点(1, 1)在右上角。
 *  索引数组是顶点数组的索引，把squareVertexData数组看成4个顶点，每个顶点会有5个GLfloat数据，索引从0开始。
 */

- (void)uploadVertetArray
{
    //顶点数据，前三个是顶点坐标(x, y, z) 后两个是文理坐标(x, y)
    GLfloat verTexData[] = {
        0.5, 0.5, -0.0f, 1.0f, 1.0f, //右上
        0.5, -0.5, 0.0f, 1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f, 0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f, 0.0f, 0.0f, //左下
    };
    
//    GLfloat verTexData[] = {
//        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
//        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
//        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
//
//        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
//        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
//        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
//    };
    
    
    //顶点数据缓存
    GLuint buffer;
    //glGenBuffers申请一个标识符
    glGenBuffers(1, &buffer);
    //glBindBuffer把标识符绑定到GL_ARRAY_BUFFER上
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    //glBufferData把顶点数据从cpu内存复制到gpu内存
    glBufferData(GL_ARRAY_BUFFER, sizeof(verTexData), verTexData, GL_STATIC_DRAW);
    
    //glEnableVertexAttribArray 是开启对应的顶点属性
    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
    //glVertexAttribPointer设置合适的格式从buffer里面读取数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //文理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
}


- (void)uploadTexture
{
    
    //文理贴图
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"jpg"];
    UIImage *image = [UIImage imageNamed:@"for_test.jpg"];
    //GLKTextureLoaderOriginBottomLeft 文理坐标系是相反的
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];
    
//    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:image.CGImage options:options error:nil];
    //着色器
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;
    
    
}



/** 渲染场景代码 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect·
{
    glClearColor(0.3, 0.6, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.mEffect prepareToDraw];
//    glDrawArrays(GL_TRIANGLES, 0, 6);
    
    //用4个点的话 绘制连续的三角形
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}


@end
