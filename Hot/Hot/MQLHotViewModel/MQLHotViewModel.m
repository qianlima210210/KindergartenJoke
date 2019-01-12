//
//  MQLHotViewModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLHotViewModel.h"

@implementation MQLHotViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLHotDataModel new];
    }
    return self;
}

@end
