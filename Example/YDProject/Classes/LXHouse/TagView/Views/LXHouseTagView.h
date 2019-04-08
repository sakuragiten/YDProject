//
//  LXHouseTagView.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXHouseTagView : UIView

@property(nonatomic, copy) NSArray<NSString *> *tagsArray;

@property(nonatomic, copy) void (^heightRefresh)(CGFloat height);


- (void)reloadData;


@end

NS_ASSUME_NONNULL_END
