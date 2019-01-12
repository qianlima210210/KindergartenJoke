//
//  MQLHotDetailViewModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLHotDetailViewModel.h"

@implementation MQLHotDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLHotDetailDataModel new];
    }
    return self;
}

@end
