//
//  GSVideoRecorder.h
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/9/11.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GSRecorderCameraPosition) {
    GSRecorderCameraPositionFront = 0,
    GSRecorderCameraPositionBack,
};

typedef NS_ENUM(NSInteger, GSRecorderDeviceAuthor) {
    GSRecorderDeviceAuthorEnabled,
    GSRecorderDeviceAuthorAudioDenied,
    GSRecorderDeviceAuthorVideoDenied
};


@protocol GSVideoRecorderDelegate <NSObject>

@required
/**
 设备权限
 @param status 设备权限状态
 */
- (void)recorderDeviceAuthorization:(GSRecorderDeviceAuthor)status;

@end












@interface GSVideoRecorder : NSObject

/**
 预览视图

 必须设置
 */
@property(nonatomic, strong) UIView *preview;

/**
 视频的输出路径

 必须设置
 */
@property(nonatomic, copy) NSString *outputPath;


/**
 taskPath文件夹路径

 需要保证文件夹已经创建，必须设置
 */
@property(nonatomic, copy) NSString *taskPath;


/**
 Delegate
 */
@property(nonatomic, weak) id<GSVideoRecorderDelegate> delegate;




/**
 手动对焦点，相对预览视图的位置
 */
@property(nonatomic, assign) CGPoint focusPoint;




/**
 初始化

 @param delegate 代理
 @param videoSize 视频分辨率，必须为偶数，不能是奇数，不能使用屏幕分辨率
 建议使用的分辨率 320*480,540*960,720*1280
 @return AliyunIRecorder 对象
 */
- (instancetype)initWithDelegate:(id<GSVideoRecorderDelegate>)delegate videoSize:(CGSize)videoSize;



/**
 开始预览

 @param cameraPosition 摄像头位置（前置、后置）
 */
- (void)startPreviewWithPositon:(GSRecorderCameraPosition)cameraPosition;



/**
 切换摄像头

 @param position 摄像头方向 默认后置 AVCaptureDevicePositionBack
 */
- (void)switchCameraPosition:(GSRecorderCameraPosition)cameraPosition;


/**
 开始预览 默认前置摄像头
 */
- (void)startPreview;


/**
 停止预览
 */
- (void)stopPreview;


/**
 改变视频分辨率

 @param videoSize 视频分辨率
 */
- (void)reStartPreviewWithVideoSize:(CGSize)videoSize;


/**
 获取摄像头位置
 */
@property(nonatomic, assign, readonly) GSRecorderCameraPosition cameraPosition;



@end

NS_ASSUME_NONNULL_END
