//
//  LXBroadcastView.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/6/12.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXBroadcastView : UIView


@property (nonatomic, assign) CGFloat timerInterval;    //default is 3.0;

@property(nonatomic, assign) NSInteger selectIndex; //default is 0


@property (nonatomic, copy) NSArray *dataArray;




@end



NS_ASSUME_NONNULL_END


@interface LXBroadcastContentView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UILabel *subContentLabel;





@end
