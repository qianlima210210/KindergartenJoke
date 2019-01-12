//
//  MQLLatestViewModel.h
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQLLatestViewModel : NSObject

@property (nonatomic, strong) MQLLatestDataModel *dataModel;
@property (nonatomic, strong) NSMutableArray *jokeItemViewModels;

@property (nonatomic, assign) NSInteger pageNumber;     //当前数据已到第几页

//发送请求
- (NSURLSessionDataTask *)getLatestSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END