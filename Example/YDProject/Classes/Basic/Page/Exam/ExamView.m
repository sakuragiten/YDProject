//
//  ExamView.m
//  YDProject_Example
//
//  Created by gongsheng on 2020/2/8.
//  Copyright © 2020 387970107@qq.com. All rights reserved.
//

#import "ExamView.h"


@implementation ExamView

+ (instancetype)examView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ExamViewff" owner:nil options:nil].lastObject;
}

@end
