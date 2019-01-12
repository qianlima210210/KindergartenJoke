//
//  MQLLatestDetailViewModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLLatestDetailViewModel.h"

@implementation MQLLatestDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLLatestDetailDataModel new];
    }
    return self;
}

@end
