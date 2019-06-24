//
//  UITableViewCell+Extension.m
//  YDProject
//
//  Created by louxunmac on 2019/4/17.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

+ (instancetype)cellFromeXibWithTableView:(UITableView *)tableView
{
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}


@end
