//
//  SwitchButtonCell.h
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwitchButtonCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL switchON;

@property (nonatomic, copy) void (^switchHandle)(UISwitch *sender);

@end

NS_ASSUME_NONNULL_END
