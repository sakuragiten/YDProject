//
//  UITableViewCell+Extension.h
//  YDProject
//
//  Created by louxunmac on 2019/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Extension)

/** 从xib加载cell */
+ (instancetype)cellFromeXibWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
