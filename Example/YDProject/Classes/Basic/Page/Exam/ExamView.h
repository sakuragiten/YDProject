//
//  ExamView.h
//  YDProject_Example
//
//  Created by gongsheng on 2020/2/8.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamView : UIView

@property (weak, nonatomic) IBOutlet UILabel *f1;


@property (weak, nonatomic) IBOutlet UILabel *f2;


@property (weak, nonatomic) IBOutlet UITextField *f3;

@property (weak, nonatomic) IBOutlet UILabel *score;

@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UIButton *btn;

+ (instancetype)examView;

@end

NS_ASSUME_NONNULL_END
