//
//  GSVideoCapture.h
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/9/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol GSVideoCaptureDelegate <NSObject>

@optional

/**
 视频采集出错
 @param errorMsg  报错信息
 */
- (void)capturFailedWithErrorMessage:(NSString *)errorMsg;



/**
 视频采集数据输出
 @param sampleBuffer  采集到的视频样本数据
 */
- (void)didVideoOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;



/**
 音频采集数据输出
 @param sampleBuffer  采集到的音频样本数据
 */
- (void)didAudioOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end


@interface GSVideoCapture : NSObject


/**
 Delegate
 */
@property(nonatomic, weak) id<GSVideoCaptureDelegate> delegate;



/**
 预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;



/**
 摄像头方向 前置、后置

 默认后置 AVCaptureDevicePositionBack
 */
@property (nonatomic, assign) AVCaptureDevicePosition cameraPosition;



/**
 切换摄像头

 @param position 摄像头方向 默认后置 AVCaptureDevicePositionBack
 */
- (void)switchCameraPosition:(AVCaptureDevicePosition)position;


/**
 开始捕捉画面 默认前置摄像头
 */
- (void)startCapture;



/**
 开始捕捉画面 默认前置摄像头
 
 @param position 摄像头方向 默认后置 AVCaptureDevicePositionBack
 */
- (void)startCaptureWithPosition:(AVCaptureDevicePosition)position;


/**
 进行聚焦
 
 @param point 聚焦的点坐标
 */
- (void)autoFocusAtPoint:(CGPoint)point;



@end

NS_ASSUME_NONNULL_END
