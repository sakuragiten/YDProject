//
//  GSVideoRecorder.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/9/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "GSVideoRecorder.h"

#import "GSVideoCapture.h"
#import "GSCaptureFocusView.h"

@interface GSVideoRecorder ()<GSVideoCaptureDelegate>

@property (nonatomic, assign) CGSize videoSize;

// 当前的授权状态
@property (nonatomic, assign) GSRecorderDeviceAuthor authorStatus;

// 是否有音频视频录制的权限
@property (nonatomic, assign) BOOL recordAccess;

// 预览层
//@property (nonatomic, strong) UIImageView *preImageView;

// 摄像头画面采集
@property (nonatomic, strong) GSVideoCapture *capture;

// 聚焦框
@property (nonatomic, strong) GSCaptureFocusView *focusView;

// 聚焦的点击事件
@property (nonatomic, strong) UITapGestureRecognizer *focusTapGesture;

@end

@implementation GSVideoRecorder



- (instancetype)initWithDelegate:(id<GSVideoRecorderDelegate>)delegate videoSize:(CGSize)videoSize
{
    if (self = [super init]) {
        _delegate = delegate;
        _videoSize = videoSize;
        
        [self recordConfiguration];
    }
    return self;
}

- (void)recordConfiguration
{
    _cameraPosition = GSRecorderCameraPositionBack;
    
    _capture = [GSVideoCapture new];
    _capture.delegate = self;
    
    self.focusTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foucsTapAction:)];
    
    
    self.focusView = [[GSCaptureFocusView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    [self rquestAccessAboutVideoRecord];
}



- (void)startPreview
{
    
    // 无权限
    if (self.recordAccess == NO) return;
    
    // 设置预览的配置
    [self prepareToStartPreView];
    
    // 开始采集
    [self.capture startCapture];
    
}


- (void)reStartPreviewWithVideoSize:(CGSize)videoSize
{
    _videoSize = videoSize;
    
    [self startPreview];
}


- (void)startPreviewWithPositon:(GSRecorderCameraPosition)cameraPosition
{
    _cameraPosition = cameraPosition;
    
    [self.capture startCaptureWithPosition:cameraPosition == GSRecorderCameraPositionFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack];
}

- (void)prepareToStartPreView
{
//    [self.preImageView removeFromSuperview];
//    [self.preview addSubview:self.preImageView];
//    self.preImageView.frame = self.preview.bounds;
    
    [self.focusView removeFromSuperview];
    [self.preview addSubview:self.focusView];
    
    [self.capture.videoPreviewLayer removeFromSuperlayer];
    self.capture.videoPreviewLayer.frame = self.preview.bounds;
    [self.preview.layer insertSublayer:self.capture.videoPreviewLayer atIndex:0];

    
    [self.preview removeGestureRecognizer:self.focusTapGesture];
    [self.preview addGestureRecognizer:self.focusTapGesture];
    
    self.capture.cameraPosition =  self.cameraPosition == GSRecorderCameraPositionFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
}


#pragma mark - 聚焦点击
- (void)foucsTapAction:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:tap.view];
    [self.focusView setFrameByAnimateWithCenter:tapPoint];
    [self.capture autoFocusAtPoint:[self convertToPointOfInterestFromViewCoordinates:tapPoint]];
}

- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates
{
    CGPoint pointOfInterest = CGPointMake(.5f, .5f);
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = self.capture.videoPreviewLayer;
    CGSize frameSize = [captureVideoPreviewLayer frame].size;
    
    if ([captureVideoPreviewLayer.connection isVideoMirrored]) {
        viewCoordinates.x = frameSize.width - viewCoordinates.x;
    }
    
    pointOfInterest = [captureVideoPreviewLayer captureDevicePointOfInterestForPoint:viewCoordinates];
    return pointOfInterest;
}


#pragma mark - 切换摄像头
- (void)switchCameraPosition:(GSRecorderCameraPosition)cameraPosition
{
    _cameraPosition = cameraPosition;

    [self.capture switchCameraPosition:cameraPosition == GSRecorderCameraPositionFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack];
}


#pragma mark - GSVideoCaptureDelegate

// 报错信息
- (void)capturFailedWithErrorMessage:(NSString *)errorMsg
{
    NSLog(@"%@", errorMsg);
}

// 视频数据
- (void)didVideoOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVPixelBufferRef pixbuffer = [self cropSampleBuffer:sampleBuffer videoSize:self.videoSize];
    dispatch_sync(dispatch_get_main_queue(), ^{
//        self.preImageView.image = [self imageConvert:pixbuffer];
    });
//    CMTime time = CMSampleBufferGetPresentationTimeStamp(buffer);
//    [self.writerManager appendPixelBuffer:pixbuffer atTime:time];
//    [self updateVideoRecordView];
    CVPixelBufferRelease(pixbuffer);
}

// 音频数据
- (void)didAudioOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    
}



- (CVPixelBufferRef)cropSampleBuffer:(CMSampleBufferRef)sampleBuffer videoSize:(CGSize)videoSize {
    CGFloat aspectRatio = 9.0 / 16.0;
    OSStatus status;
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,kCVPixelBufferLock_ReadOnly);
    uint8_t *baseAddress     = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t  bytesPerRow      = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t  width            = CVPixelBufferGetWidth(imageBuffer);
    size_t  height           = CVPixelBufferGetHeight(imageBuffer);
    NSInteger bytesPerPixel  = bytesPerRow/width;

    // 图片方向是横的,宽高和屏幕相反
    int destinationX      = 0;
    int destinationY      = 0;
    int destinationWidth  = height/aspectRatio;
    int destinationHeight = (int)height;

    if (destinationX % 2 != 0) destinationX += 1;
    NSInteger baseAddressStart = destinationY*bytesPerRow + destinationX*bytesPerPixel;
    
    CVPixelBufferRef  pixbuffer = NULL;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool : YES],         kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool : YES],         kCVPixelBufferCGBitmapContextCompatibilityKey,
                             [NSNumber numberWithInt  : destinationWidth],  kCVPixelBufferWidthKey,
                             [NSNumber numberWithInt  : destinationHeight], kCVPixelBufferHeightKey,
                             nil];
    status = CVPixelBufferCreateWithBytes(kCFAllocatorDefault, destinationWidth, destinationHeight, kCVPixelFormatType_32BGRA, &baseAddress[baseAddressStart], bytesPerRow, NULL, NULL, (__bridge CFDictionaryRef)options, &pixbuffer);
    if (status != 0) {
        NSLog(@"Crop CVPixelBufferCreateWithBytes error %d",(int)status);
        return NULL;
    }
    CVPixelBufferUnlockBaseAddress(imageBuffer,kCVPixelBufferLock_ReadOnly);

    return pixbuffer;
}

- (UIImage *)imageConvert:(CVPixelBufferRef)buffer {
    CVPixelBufferRef imageBuffer = buffer;
    if (!imageBuffer) {
        return nil;
    }
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress     = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t  bytesPerRow      = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t  width            = CVPixelBufferGetWidth(imageBuffer);
    size_t  height           = CVPixelBufferGetHeight(imageBuffer);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);

    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationRight];
    CGImageRelease(quartzImage);
    
    return image;
}



#pragma mark - 获取权限
- (void)rquestAccessAboutVideoRecord
{
    [self requestVideoRecordAccessWithType:AVMediaTypeAudio then:^(BOOL granted) {
        if (granted) {
            [self requestVideoRecordAccessWithType:AVMediaTypeVideo then:^(BOOL granted) {
                if (granted) {
                    self.recordAccess = YES;
                    [self recorderDeviceAuthorization:GSRecorderDeviceAuthorEnabled];
                } else {
                    self.recordAccess = NO;
                    [self recorderDeviceAuthorization:GSRecorderDeviceAuthorVideoDenied];
                }
            }];
        } else {
            self.recordAccess = NO;
            [self recorderDeviceAuthorization:GSRecorderDeviceAuthorAudioDenied];
        }
    }];
}


- (void)requestVideoRecordAccessWithType:(AVMediaType)mediaType then:(void(^)(BOOL granted))then
{
    AVAuthorizationStatus audioStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (audioStatus == AVAuthorizationStatusAuthorized) {
        !then ? : then(YES);
    } else if (audioStatus == AVAuthorizationStatusRestricted || audioStatus == AVAuthorizationStatusDenied) {
        !then ? : then(NO);
    } else {
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                !then ? : then(granted);
            });
        }];
    }
}




- (void)recorderDeviceAuthorization:(GSRecorderDeviceAuthor)status {
    if ([self.delegate respondsToSelector:@selector(recorderDeviceAuthorization:)]) {
        [self.delegate recorderDeviceAuthorization:status];
    }
}


@end
