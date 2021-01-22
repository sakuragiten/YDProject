//
//  YDCurveView.h
//  YDProject_Example
//
//  Created by gongsheng on 2020/12/7.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDCurveView : UIView



/*
 * 刷新数据 重新开始动画
 */
-(void)refreshChartAnmition;

/* 根据数据源画图
 *  pathX :横坐标数据
 *
 *  pathY :纵坐标数据源
 *  X:X轴需要切割的份数
 */
-(void)drawSmoothViewWithArrayX:(NSArray*)pathX andArrayY:(NSArray*)pathY andScaleX:(float)X;


@end

NS_ASSUME_NONNULL_END
