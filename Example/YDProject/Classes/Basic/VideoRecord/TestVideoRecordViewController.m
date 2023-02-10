//
//  TestVideoRecordViewController.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/9/9.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "TestVideoRecordViewController.h"

//#import <mobileffmpeg/MobileFFmpegConfig.h>
//#import <mobileffmpeg/MobileFFprobe.h>
//#import <libavutil/avutil.h>
//#import <libavformat/avformat.h>
//#import <libavdevice/avdevice.h>


#import "GSVideoRecorder.h"

@interface TestVideoRecordViewController ()<GSVideoRecorderDelegate>

@property (nonatomic, strong) GSVideoRecorder *recorder;

@property(nonatomic, strong) UIView *preview;

@end

@implementation TestVideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStylePlain target:self action:@selector(testAction)];
    self.navigationItem.rightBarButtonItem = rigthItem;
    
    _preview = [UIView new];
    _preview.backgroundColor = [UIColor cyanColor];
    self.preview.frame = self.view.bounds;
    [self.view addSubview:self.preview];
    
    
    _recorder = [[GSVideoRecorder alloc] initWithDelegate:self videoSize:[self videoSizeWithAspectRatio:9.0 / 16.0]];
    _recorder.preview = self.preview;
    
    [self.recorder startPreview];
    
}

- (CGSize)videoSizeWithAspectRatio:(CGFloat)aspectRatio
{
    //容错，导出须为偶数 以 720p 为基础
    CGFloat w = 720;
    CGFloat h = ceilf(w / aspectRatio);
    int int_h = h;
    int_h = int_h / 2 * 2;
    h = int_h;
    return CGSizeMake(w, h);
}




- (void)testAction
{
    if (self.recorder.cameraPosition == GSRecorderCameraPositionFront) {
        [self.recorder switchCameraPosition:GSRecorderCameraPositionBack];
    } else {
        [self.recorder switchCameraPosition:GSRecorderCameraPositionFront];
    }
}

#pragma mark - GSVideoRecorderDelegate
/**
 设备权限
 @param status 设备权限状态
 */
- (void)recorderDeviceAuthorization:(GSRecorderDeviceAuthor)status
{
    if (status == GSRecorderDeviceAuthorAudioDenied) {
        NSLog(@"麦克风无权限");
    } else if (status == GSRecorderDeviceAuthorVideoDenied) {
        NSLog(@"摄像头无权限");
    }
}





- (void)testAction2
{
    int ret = 0;
//    char errors[1024];
//    AVFormatContext *fmt_ctx = NULL;
//    AVDictionary *options = NULL;
//    // [[video device]:[audio device]]
//    char *devicename = ":0"; // 从第一个音频获取数据
//    avdevice_register_all();
//    AVInputFormat *iformat = av_find_input_format("avfoundation");
//    ret = avformat_open_input(&fmt_ctx, devicename, iformat, &options);
//    if (ret < 0) {
//        av_strerror(ret, errors, 1024);
//        printf(stderr, "failed to open audio device, [%s]%s\n", ret, errors);
//        return;
//    }
}


//
//- (void)testAction1
//{
////    int rc = [MobileFFprobe execute: @"-i file1.mp4"];
////
////    if (rc == RETURN_CODE_SUCCESS) {
////        NSLog(@"Command execution completed successfully.\n");
////    } else if (rc == RETURN_CODE_CANCEL) {
////        NSLog(@"Command execution cancelled by user.\n");
////    } else {
////        NSLog(@"Command execution failed with rc=%d and output=%@.\n", rc, [MobileFFmpegConfig getLastCommandOutput]);
////    }
////
//    av_register_all();
//
//    const char *in_filename, *out_filename;
//    AVOutputFormat *ofmt = NULL;
//    AVFormatContext *ifmt_ctx = NULL;
//    AVFormatContext *ofmt_ctx = NULL;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"YYYY-MM-dd hh:mm:ss";
//    NSString *date = [formatter stringFromDate:[NSDate date]];
//
//    in_filename = [[NSString stringWithFormat:@"%@/Video_rercord/%@.mp4", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ,date] cStringUsingEncoding:NSASCIIStringEncoding];
//    out_filename = [[NSString stringWithFormat:@"%@/Video/%@.mp4", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ,date] cStringUsingEncoding:NSASCIIStringEncoding];
//    int ret = avformat_open_input(&ifmt_ctx, in_filename, 0, 0);
//    if (ret < 0) {
//        printf( "Could not open input file.");
//        goto end;
//    }
//    ret = avformat_find_stream_info(ifmt_ctx, 0);
//    if (ret < 0) {
//        printf( "Failed to retrieve input stream information");
//        goto end;
//    }
//    av_dump_format(ifmt_ctx, 0, in_filename, 0);
//
//    //输出（Output）
////    avformat_alloc_output_context2(AVFormatContext **ctx, AVOutputFormat *oformat, const char *format_name, const char *filename)
//    avformat_alloc_output_context2(&ofmt_ctx, NULL, NULL, out_filename);
//    if (!ofmt_ctx) {
//        printf( "Could not create output context\n");
//        ret = AVERROR_UNKNOWN;
//        goto end;
//    }
//    ofmt = ofmt_ctx->oformat;
//    for (int i = 0; i < ifmt_ctx->nb_streams; i++) {
//        //根据输入流创建输出流（Create output AVStream according to input AVStream）
//        AVStream *in_stream = ifmt_ctx->streams[i];
//        AVStream *out_stream = avformat_new_stream(ofmt_ctx, in_stream->codec->codec);
//        if (!out_stream) {
//            printf( "Failed allocating output stream\n");
//            ret = AVERROR_UNKNOWN;
//            goto end;
//        }
//        //复制AVCodecContext的设置（Copy the settings of AVCodecContext）
//        ret = avcodec_copy_context(out_stream->codec, in_stream->codec);
//        if (ret < 0) {
//            printf( "Failed to copy context from input to output stream codec context\n");
//            goto end;
//        }
//        out_stream->codec->codec_tag = 0;
//        if (ofmt_ctx->oformat->flags & AVFMT_GLOBALHEADER)
//            out_stream->codec->flags |= AV_CODEC_FLAG_GLOBAL_HEADER; //CODEC_FLAG_GLOBAL_HEADER
//    }
//
//end:
//    avformat_close_input(&ifmt_ctx);
//    /* close output */
//    if (ofmt_ctx && !(ofmt->flags & AVFMT_NOFILE))
//        avio_close(ofmt_ctx->pb);
//    avformat_free_context(ofmt_ctx);
//    if (ret < 0 && ret != AVERROR_EOF) {
//        printf( "Error occurred.\n");
//    }
//
    
//}
@end
