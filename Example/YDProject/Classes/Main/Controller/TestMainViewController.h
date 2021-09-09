//
//  TestMainViewController.h
//  YDProject_Example
//
//  Created by gongsheng on 2018/11/8.
//  Copyright © 2018 387970107@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TestMainViewController : UIViewController

- (TestViewModelType)getDataType;

@property (nonatomic, strong) TestViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
