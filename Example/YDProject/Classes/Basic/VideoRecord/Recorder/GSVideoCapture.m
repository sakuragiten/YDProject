//
//  GSVideoCapture.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/9/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "GSVideoCapture.h"

@interface GSVideoCapture ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

// 捕捉视频和音频,协调视频和音频的输入和输出流.
@property (nonatomic, strong) AVCaptureSession *captureSession;

// 视频采集设备
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;

// 音频采集设备
@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;

// 视频输出端
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;

// 音频输出端
@property (nonatomic, strong) AVCaptureAudioDataOutput *audioOutput;

// 视频输出回调队列
@property (nonatomic, strong) dispatch_queue_t videoQueue;

// 音频输出回调队列
@property (nonatomic, strong) dispatch_queue_t audioQueue;



@end



@implementation GSVideoCapture

- (instancetype)init
{
    if (self = [super init]) {
        [self captureConfiguration];
    }
    return self;
}


- (void)captureConfiguration
{
    // 默认 后置摄像头
    _cameraPosition = AVCaptureDevicePositionBack;
    
    _captureSession = [AVCaptureSession new];
    
    // 创建音视频输出的同步队列
    self.videoQueue = dispatch_queue_create("com.gs_video_output_queue", DISPATCH_QUEUE_SERIAL);
    self.audioQueue = dispatch_queue_create("com.gs_audio_output_queue", DISPATCH_QUEUE_SERIAL);
    
    self.videoOutput = [AVCaptureVideoDataOutput new];
    self.videoOutput.alwaysDiscardsLateVideoFrames = YES;
    [self.videoOutput setSampleBufferDelegate:self queue:self.videoQueue];
    NSString *key = (NSString *)kCVPixelBufferPixelFormatTypeKey;
    NSNumber *value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [self.videoOutput setVideoSettings:videoSettings];
    
    
    self.audioOutput = [AVCaptureAudioDataOutput new];
    [self.audioOutput setSampleBufferDelegate:self queue:self.audioQueue];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}



- (void)startCapture
{
    // 已经开始了
    if (self.captureSession.isRunning) return;
    
    if ([self setupInputSession] == NO) return;
    
    if ([self setupOutputSession] == NO) return;
    
    [self.captureSession startRunning];
}

- (void)startCaptureWithPosition:(AVCaptureDevicePosition)position
{
    if (self.captureSession.isRunning) {
        [self switchCameraPosition:position];
    } else {
        self.cameraPosition = position;
        [self startCapture];
    }
    
    
    
}

// 设置输入流
- (BOOL)setupInputSession
{
    // 获取摄像头
    AVCaptureDevice *videoDevice = [self cameraDeviceWithPosition:self.cameraPosition];
    if (videoDevice == nil) {
        [self throwCaptureFailedMessage:@"获取摄像设备出错"];
        return NO;
    }
    
    NSError *error = nil;
    // 创建视频采集对象
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:&error];
    if (error) {
        [self throwCaptureFailedMessage:error.userInfo.description];
        return NO;
    }
    

    if ([self.captureSession canAddInput:self.videoInput]) {
        [self.captureSession addInput:self.videoInput];
    }
    
    
    // 获取音频设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    if (audioDevice == nil) {
        [self throwCaptureFailedMessage:@"获取麦克风设备出错"];
        return NO;
    }
    
    // 创建音频采集对象
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:&error];
    if (error) {
        [self throwCaptureFailedMessage:error.userInfo.description];
        return NO;
    }
    
    
    if ([self.captureSession canAddInput:self.audioInput]) {
        [self.captureSession addInput:self.audioInput];
    }
    
    return YES;
}

// 设置输出流
- (BOOL)setupOutputSession
{
    if ([self.captureSession canAddOutput:self.videoOutput]) {
        [self.captureSession addOutput:self.videoOutput];
    }
    
    if ([self.captureSession canAddOutput:self.audioOutput]) {
        [self.captureSession addOutput:self.audioOutput];
    }
    
    return YES;
}


// 获取对应的采集设备 摄像头
- (AVCaptureDevice *)cameraDeviceWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *cameraArray = nil;
    if (@available(iOS 10.0,*)) {
        AVCaptureDeviceDiscoverySession *deviceSeesion = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
        cameraArray = deviceSeesion.devices;
    } else {
        cameraArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    }
    for (AVCaptureDevice *camera in cameraArray) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

#pragma mark - 切换镜头
- (void)switchCameraPosition:(AVCaptureDevicePosition)position
{
    if (self.cameraPosition == position) return;
    
    AVCaptureDevice *videoDevice = [self cameraDeviceWithPosition:position];
    if (videoDevice == nil) {
        [self throwCaptureFailedMessage:@"获取摄像设备出错"];
        return;
    }
    
    NSError *error = nil;
    // 创建视频采集对象
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:&error];
    if (error) {
        [self throwCaptureFailedMessage:error.userInfo.description];
        return;
    }
    
    self.cameraPosition = position;
    
    // 添加镜头的切换转场动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    animation.type = @"oglFlip";
    animation.removedOnCompletion = YES;
    if (position == AVCaptureDevicePositionFront) {
        animation.subtype = kCATransitionFromLeft;
    } else if (position == AVCaptureDevicePositionBack){
        animation.subtype = kCATransitionFromRight;
    }
    [self.videoPreviewLayer addAnimation:animation forKey:nil];
    
    
    [self.captureSession beginConfiguration];
    [self.captureSession removeInput:self.videoInput];
    if ([self.captureSession canAddInput:videoInput]) {
        [self.captureSession addInput:videoInput];
        self.videoInput = videoInput;
    }
    [self.captureSession commitConfiguration];
    
    
    AVCaptureConnection *connection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    connection.videoMirrored = (position == AVCaptureDevicePositionFront);
    connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
}


- (void)throwCaptureFailedMessage:(NSString *)msg
{
    if ([self.delegate respondsToSelector:@selector(capturFailedWithErrorMessage:)]) {
        [self.delegate capturFailedWithErrorMessage:msg];
    }
}

// 聚焦点
- (void)autoFocusAtPoint:(CGPoint)point
{
    AVCaptureDevice *device = self.videoInput.device;
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            [device setExposurePointOfInterest:point];
            [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            [device unlockForConfiguration];
        }
    }
}




#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate
/*!
 @method captureOutput:didOutputSampleBuffer:fromConnection:
 @abstract
    Called whenever an AVCaptureVideoDataOutput instance outputs a new video frame.
 
 @param output
    The AVCaptureVideoDataOutput instance that output the frame.
 @param sampleBuffer
    A CMSampleBuffer object containing the video frame data and additional information about the frame, such as its format and presentation time.
 @param connection
    The AVCaptureConnection from which the video was received.
 
 @discussion
    Delegates receive this message whenever the output captures and outputs a new video frame, decoding or re-encoding it as specified by its videoSettings property. Delegates can use the provided video frame in conjunction with other APIs for further processing. This method will be called on the dispatch queue specified by the output's sampleBufferCallbackQueue property. This method is called periodically, so it must be efficient to prevent capture performance problems, including dropped frames.
 
    Clients that need to reference the CMSampleBuffer object outside of the scope of this method must CFRetain it and then CFRelease it when they are finished with it.
 
    Note that to maintain optimal performance, some sample buffers directly reference pools of memory that may need to be reused by the device system and other capture inputs. This is frequently the case for uncompressed device native capture where memory blocks are copied as little as possible. If multiple sample buffers reference such pools of memory for too long, inputs will no longer be able to copy new samples into memory and those samples will be dropped. If your application is causing samples to be dropped by retaining the provided CMSampleBuffer objects for too long, but it needs access to the sample data for a long period of time, consider copying the data into a new buffer and then calling CFRelease on the sample buffer if it was previously retained so that the memory it references can be reused.
 */
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (output == self.videoOutput) {
        // 视频采集数据输出
        if ([self.delegate respondsToSelector:@selector(didVideoOutputSampleBuffer:)]) {
            [self.delegate didVideoOutputSampleBuffer:sampleBuffer];
        }
    } else {
        // 音频数据采集输出
        if ([self.delegate respondsToSelector:@selector(didAudioOutputSampleBuffer:)]) {
            [self.delegate didAudioOutputSampleBuffer:sampleBuffer];
        }
    }
}



@end



@implementation GSVideoCapture (configuration)

+ (BOOL)setCameraFrameRateAndResolutionWithFrameRate:(int)frameRate
                                 andResolutionHeight:(CGFloat)resolutionHeight
                                           bySession:(AVCaptureSession *)session
                                            position:(AVCaptureDevicePosition)position
                                         videoFormat:(OSType)videoFormat {
    
    AVCaptureDevice *captureDevice = [self getCaptureDevicePosition:position];
    BOOL isSuccess = NO;
    for(AVCaptureDeviceFormat *vFormat in [captureDevice formats]) {
        CMFormatDescriptionRef description = vFormat.formatDescription;
        float maxRate = ((AVFrameRateRange*) [vFormat.videoSupportedFrameRateRanges objectAtIndex:0]).maxFrameRate;
        if (maxRate >= frameRate && CMFormatDescriptionGetMediaSubType(description) == videoFormat) {
            if ([captureDevice lockForConfiguration:NULL] == YES) {
                // 对比镜头支持的分辨率和当前设置的分辨率
                CMVideoDimensions dims = CMVideoFormatDescriptionGetDimensions(description);
                if (dims.height == resolutionHeight && dims.width == [self getResolutionWidthByHeight:resolutionHeight]) {
                    [session beginConfiguration];
                    if ([captureDevice lockForConfiguration:NULL]){
                        captureDevice.activeFormat = vFormat;
                        [captureDevice setActiveVideoMinFrameDuration:CMTimeMake(1, frameRate)];
                        [captureDevice setActiveVideoMaxFrameDuration:CMTimeMake(1, frameRate)];
                        [captureDevice unlockForConfiguration];
                    }
                    [session commitConfiguration];
                    
                    return YES;
                }
            } else {
                NSLog(@"%s: lock failed!",__func__);
            }
        }
    }
    
    NSLog(@"Set camera frame is success : %d, frame rate is %lu, resolution height = %f",isSuccess,(unsigned long)frameRate,resolutionHeight);
    return NO;
}

+ (AVCaptureDevice *)getCaptureDevicePosition:(AVCaptureDevicePosition)position {
    NSArray *devices = nil;
    
    if (@available(iOS 10.0, *)) {
        AVCaptureDeviceDiscoverySession *deviceDiscoverySession =  [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
        devices = deviceDiscoverySession.devices;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
#pragma clang diagnostic pop
    }
    
    for (AVCaptureDevice *device in devices) {
        if (position == device.position) {
            return device;
        }
    }
    return NULL;
}


+ (int)getResolutionWidthByHeight:(int)height {
    switch (height) {
        case 2160:
            return 3840;
        case 1080:
            return 1920;
        case 720:
            return 1280;
        case 480:
            return 640;
        default:
            return -1;
    }
}

@end
