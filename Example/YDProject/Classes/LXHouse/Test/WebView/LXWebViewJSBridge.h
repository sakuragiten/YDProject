//
//  LXWebViewJSBridge.h
//  LXNewHouse
//
//  Created by LOUXUN-K on 2018/12/3.
//  Copyright © 2018 louxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
//声明遵从JSExport协议的协议
@protocol JSObjectProtocol <JSExport>
///楼盘对比---删除某个楼盘回调
-(void)removeCompareHouse:(NSString *)data;
///楼盘对比--增加楼盘事件回调
-(void)addCompareHouse;
///点击楼盘--进楼盘详情
- (void)startNewHouse:(NSString *)data;
///查看更多--百科推荐楼盘
- (void)startWebH5:(NSString *)data;
- (void)openImage:(id)data img:(NSString *)img;

- (void)aopenImage:(id)data;
@end

@protocol LXWebViewJSBridgeDelegate <NSObject>

@optional
/*在此处定义交互方法*/
///楼盘对比---删除某个楼盘回调
-(void)removeCompareHouse:(NSString *)data;
///楼盘对比--增加楼盘事件回调
-(void)addCompareHouse;
///点击楼盘--进楼盘详情
- (void)startNewHouse:(NSString *)data;
///查看更多--百科推荐楼盘
- (void)startWebH5:(NSString *)data;
- (void)openImage:(id)data img:(NSString *)img;
- (void)aopenImage:(id)data;

@end

@interface LXWebViewJSBridge : NSObject<JSObjectProtocol>
@property (nonatomic,weak) id<LXWebViewJSBridgeDelegate> delegate;
@end

