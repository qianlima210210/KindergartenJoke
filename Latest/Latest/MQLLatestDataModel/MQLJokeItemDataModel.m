//
//  MQLJokeItemDataModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLJokeItemDataModel.h"

@implementation MQLJokeItemDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"";
        _content = @"";
    }
    return self;
}

@end
