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

//translate request
- (NSURLSessionDataTask *)traslateChineseContent:(NSString*)chineseContent success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{

    NSString *url = @"http://fanyi.youdao.com/translate";
    NSString *from = @"ZH_CN";
    NSString *to = @"EN";
    NSString *q = chineseContent;
    NSString *u = @"fanyideskweb";
    NSString *d = q;
    long ctime = (long)[NSDate date].timeIntervalSince1970 * 1000;
    NSString *f = [NSString stringWithFormat:@"%zd", ctime + rand() % 10 + 1];
    NSString *c = @"p09@Bn{h02_BIEe]$P^nG";
    
    //String sign = md5(u + d + f + c);
    NSString *input = [NSString stringWithFormat:@"%@%@%@%@", u, d, f, c];
    NSString *sign = [input md5_32bit];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:q forKey:@"i"];
    [params setObject:from forKey:@"from"];
    [params setObject:to forKey:@"to"];
    [params setObject:@"rule" forKey:@"smartresult"];
    [params setObject:@"fanyideskweb" forKey:@"client"];
    [params setObject:f forKey:@"salt"];
    [params setObject:sign forKey:@"sign"];
    [params setObject:@"json" forKey:@"doctype"];
    [params setObject:@"2.1" forKey:@"version"];
    [params setObject:@"fanyi.web" forKey:@"keyfrom"];
    [params setObject:@"FY_BY_CLICKBUTTION" forKey:@"action"];
    [params setObject:@"false" forKey:@"typoResult"];
    
    __block NSMutableString *queryString = [NSMutableString new];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *value = [obj URLEncodedString];
        [queryString appendFormat:@"%@=%@&", key, value];
    }];
    //删除最后一个“&”
    [queryString deleteCharactersInRange:NSMakeRange(queryString.length - 1, 1)];
    //url = [NSString stringWithFormat:@"%@&%@", url, queryString];
    
    
    NSURL *url1 = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [queryString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setValue:[NSString stringWithFormat:@"%@%zd",@"OUTFOX_SEARCH_USER_ID_NCOO=1537643834.9570553; OUTFOX_SEARCH_USER_ID=1799185238@10.169.0.83; fanyi-ad-id=43155; fanyi-ad-closed=1; JSESSIONID=aaaBwRanNsqoobhgvaHmw; _ntes_nnid=07e771bc10603d984c2dc8045a293d30,1525267244050; ___rl__test__cookies=", ctime] forHTTPHeaderField:@"Cookie"];
    
    [request setValue:@"http://fanyi.youdao.com/" forHTTPHeaderField:@"Referer"];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:64.0) Gecko/20100101 Firefox/64.0" forHTTPHeaderField:@"User-Agent"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            success(nil, responseObject);
        }else{
            failure(nil, error);
        }
    }];
    
    [task resume];
    return task;
}


@end
