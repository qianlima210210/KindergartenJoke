//
//  MQLJokeItemViewModel.h
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLJokeItemViewModel : NSObject

@property (nonatomic, strong) MQLJokeItemDataModel *dataModel;

-(CGSize)sizeForItem;

@end

NS_ASSUME_NONNULL_END
