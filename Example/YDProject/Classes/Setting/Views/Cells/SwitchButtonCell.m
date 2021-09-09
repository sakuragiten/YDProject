//
//  SwitchButtonCell.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/17.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "SwitchButtonCell.h"

@interface SwitchButtonCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;


@end

@implementation SwitchButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLabel.text = title;
}

- (void)setSwitchON:(BOOL)switchON
{
    _switchON = switchON;
    _switchBtn.on = switchON;
}

- (IBAction)switchAction:(id)sender {
    
    !_switchHandle ? : _switchHandle(sender);
}

@end
