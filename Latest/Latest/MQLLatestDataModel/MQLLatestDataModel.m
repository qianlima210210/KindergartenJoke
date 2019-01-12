//
//  MQLLatestDataModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLLatestDataModel.h"

@implementation MQLLatestDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _jokeItemDataModels = [NSMutableArray array];
    }
    return self;
}

@end
