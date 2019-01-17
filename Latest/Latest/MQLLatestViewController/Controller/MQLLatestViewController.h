//
//  MQLLatestViewController.h
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/11.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLLatestViewController : JRBaseViewController

@property (nonatomic, strong) MQLLatestViewModel *viewModel;
@property (nonatomic, assign) BOOL isLatestItem;   //是否最新项目

@end

NS_ASSUME_NONNULL_END
