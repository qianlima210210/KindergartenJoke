//
//  MQLLatestViewModel.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/12.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLLatestViewModel.h"

@implementation MQLLatestViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModel = [MQLLatestDataModel new];
        _jokeItemViewModels = [NSMutableArray array];
        _pageNumber = 0;
    }
    return self;
}

//发送请求
- (NSURLSessionDataTask *)getLatestSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    NSString *urlString = [NSString stringWithFormat:@"http://haha.sogou.com/tag/li/幼儿园/new/%zd", self.pageNumber + 1];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDataTask *task = [JRNetworkingSingleton dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error == nil) {
            success(nil, responseObject);
        }else{
            failure(nil, error);
        }
        
    }];
    return task;
}


@end
