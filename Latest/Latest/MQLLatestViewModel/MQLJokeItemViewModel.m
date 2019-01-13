//
//  MQLJokeItemViewModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLJokeItemViewModel.h"

@interface MQLJokeItemViewModel ()

@property (nonatomic, assign) CGSize size;

@end

@implementation MQLJokeItemViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLJokeItemDataModel new];
    }
    return self;
}

-(CGSize)sizeForItem{
    
    if (self.size.width == 0 || self.size.height == 0) {
        CGFloat width = kScreenWidth - 10 * 2;
        CGRect frame = [self.dataModel.content boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
        self.size = CGSizeMake(width, ceil(frame.size.height) + 1 + 20);
    }
    
    return self.size;
}

@end
