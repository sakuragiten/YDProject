//
//  OGLesson2View.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "OGLesson2View.h"
#import <OpenGLES/ES2/gl.h>


@interface OGLesson2View ()

@property (nonatomic, strong) CAEAGLLayer *myEagLayer;

@property (nonatomic, strong) EAGLContext *myContext;

@property (nonatomic, assign) GLuint myProgram;

@property (nonatomic, assign) GLuint myColorRenderBuffer;
@property (nonatomic, assign) GLuint myColorFrameBuffer;


@end

@implementation OGLesson2View


+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (void)layoutSubviews
{
    NSLog(@"%s", __func__);

    [self setupLayer];
    [self setupContext];
    [self destoryRenderAndFrameBuffer];
    [self setupRenderBuffer];
    [self setupFrameBuffer];

    [self render];
}


- (void)setupLayer
{
    self.myEagLayer = (CAEAGLLayer *)self.layer;

    //设置放大f倍数
    [self setContentScaleFactor:[UIScreen mainScreen].scale];

    //CALayer默认是透明的，必须将其设为非透明的才能出现
    self.layer.opaque = YES;

    //设置描绘属性， 在这里设置不维持渲染内容以及颜色格式为RGBA8
    //kEAGLDrawablePropertyRetainedBacking 为NO 不维持渲染内容
    self.myEagLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking,
                                          kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
                                          nil];

}

- (void)setupContext
{
    //指定 OpenGL 渲染API的版本 在这里我们使用 OpenGL ES 2.0
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:api];
    if (!context) {
        NSLog(@"Failed to initialize OpenGL ES 2.0 context");
        exit(1);
    }
    //设置当前上下文
    if (![EAGLContext setCurrentContext:context]) {
        NSLog(@"Failed to set current OpenGL Context");
        exit(1);
    }

    self.myContext = context;
}

- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_myColorFrameBuffer);
    self.myColorFrameBuffer = 0;

    glDeleteRenderbuffers(1, &_myColorRenderBuffer);
    self.myColorRenderBuffer = 0;
}

- (void)setupRenderBuffer
{
    GLuint buffer;
    glGenRenderbuffers(1, &buffer);
    self.myColorRenderBuffer = buffer;
    glBindRenderbuffer(GL_RENDERBUFFER, self.myColorRenderBuffer);

    //为颜色缓冲区分配存储空间
    [self.myContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.myEagLayer];
}

- (void)setupFrameBuffer
{
    GLuint buffer;
    glGenFramebuffers(1, &buffer);
    self.myColorFrameBuffer = buffer;
        //设置当前的frameBuffer
    glBindFramebuffer(GL_FRAMEBUFFER, self.myColorFrameBuffer);

        //将_colorRenderBuffer 装配到 GL_COLOR_ATTACHMENT0 这个装配点上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, self.myColorRenderBuffer);
}

- (void)render
{
    glClearColor(0, 1.0, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    CGFloat scale = [UIScreen mainScreen].scale;
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    glViewport(self.frame.origin.x * scale, self.frame.origin.y * scale,
               self.frame.size.width * scale, self.frame.size.height * scale);

    //读取文件路径
    NSString *vertFile = [[NSBundle mainBundle] pathForResource:@"shaderv" ofType:@"vsh"];
    NSString *fragFile = [[NSBundle mainBundle] pathForResource:@"shaderf" ofType:@"fsh"];

    //加载shader
    self.myProgram = [self loadShaders:vertFile frag:fragFile];

    //链接
    glLinkProgram(self.myProgram);
    GLint linkSuccess;
    glGetProgramiv(self.myProgram, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(self.myProgram, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"error: %@", messageString);
        return;
    } else {
        NSLog(@"link ok");
        glUseProgram(self.myProgram); //成功使用、避免由于未使用导致的bug
    }

    //前三个点是顶点坐标，后面两个是文理坐标
    GLfloat attrArr[] = {
        0.5f, -0.5f, -1.0f,     1.0f, 0.0f, //右下
        -0.5f, 0.5f, -1.0f,     0.0f, 1.0f, //左上
        -0.5f, -0.5f, -1.0f,    0.0f, 0.0f, //左下
        0.5f, 0.5f, -1.0f,      1.0f, 1.0f, //右上
        -0.5f, 0.5f, -1.0f,     0.0f, 1.0f, //左上
        0.5f, -0.5f, -1.0f,     1.0f, 0.0f, //右下

    };

    GLuint attrBuffer;
    glGenBuffers(1, &attrBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, attrBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(attrArr), attrArr, GL_DYNAMIC_DRAW);

    GLuint position = glGetAttribLocation(self.myProgram, "position");
    glVertexAttribPointer(position, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, NULL);
    glEnableVertexAttribArray(position);

    GLuint textCoor = glGetAttribLocation(self.myProgram, "textCoordinate");
    glVertexAttribPointer(textCoor, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (float *)NULL + 3);
    glEnableVertexAttribArray(textCoor);

    //加载文理
    [self setupTexture:@"for_test"];

    //获取shader里面的变量 这里记得要在glLinkProgram后面 后面
    GLuint rotate = glGetUniformLocation(self.myProgram, "rotateMatrix");

    float radians = 10 * 3.14159f / 180.f;
    float s = sin(radians);
    float c = cos(radians);

    GLfloat zRotation[16] = {
        c, -s, 0, 0.2,
        s, c, 0, 0,
        0, 0, 1.0, 0,
        0.0, 0, 0, 1.0
    };

    //设置旋转矩阵
    glUniformMatrix4fv(rotate, 1, GL_FALSE, (GLfloat *)&zRotation[0]);
    glDrawArrays(GL_TRIANGLES, 0, 6);

    [self.myContext presentRenderbuffer:GL_RENDERBUFFER];
}
/**
 *  c语言编译流程: 预编译、编译、汇编、链接
 *  glsl的编译过程主要有glCompileShader、glAttachShader、glLinkProgram
 *  @param vert 顶点着色器
 *  @param frag 片元着色器
 *
 *  @return 编译成功的shader
 */

- (GLuint)loadShaders:(NSString *)vert frag:(NSString *)frag
{
    GLuint verShader, fragShader;
    GLuint program = glCreateProgram();

    //编译
    [self compileShader:&verShader type:GL_VERTEX_SHADER file:vert];
    [self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:frag];

    glAttachShader(program, verShader);
    glAttachShader(program, fragShader);

    //释放不需要的shader
    glDeleteShader(verShader);
    glDeleteShader(fragShader);

    return program;
}

- (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    //读取字符串
    NSString *content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];

    const GLchar *source = (GLchar *)[content UTF8String];

    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
}

- (GLuint)setupTexture:(NSString *)fileName
{
    //1.获取图片的CGImageRef
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;

    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }

    //2.读取图片的大小
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);

    GLubyte *spriteData = (GLubyte *)calloc(width * height * 4, sizeof(GLubyte));
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4,
                                                       CGImageGetColorSpace(spriteImage),
                                                       kCGImageAlphaPremultipliedLast);

    //3. 在CGContextRef上绘图
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);

    //4. 绑定文理到默认的文理id 这里只有一张图片 故而相当于默认于片元着色器里面的colorMap g如果有多张图不可以这么做
    glBindTexture(GL_TEXTURE_2D, 0);


    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);


    float fw = width, fh = height;
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, fw, fh, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    glBindTexture(GL_TEXTURE_2D, 0);

    free(spriteData);

    return 0;

}




@end
