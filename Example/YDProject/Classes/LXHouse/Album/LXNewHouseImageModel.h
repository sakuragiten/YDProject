//
//  LXNewHouseImageModel.h
//  LXNewHouse
//
//  Created by louxunmac on 2018/9/6.
//  Copyright © 2018年 louxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNewHouseImageModel : NSObject
///图片描述
@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *picUrl;

@property (nonatomic,copy)NSString *videoUrl;
///0 项目效果图  1：实景图  2 样板图  3：视频
@property (nonatomic,strong)NSNumber *type;

@property (nonatomic,copy)NSString *typeName;
/**
 0:楼盘 1:户型图 2.房源 3：装修图
 */
@property (nonatomic,copy)NSString *resourceType;
///是否首图 0:非首图 1：首图
@property (nonatomic,strong)NSNumber *isFistPic;
/**
 资源ID
 */
@property (nonatomic,strong)NSNumber *resourceId;
///是否封面图 0:非封面 1：封面
@property (nonatomic,strong)NSNumber *isCoverPic;

@property (nonatomic,assign)NSInteger atIndex;

@end
