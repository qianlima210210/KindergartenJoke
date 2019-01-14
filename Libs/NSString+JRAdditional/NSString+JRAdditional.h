//
//  NSString+JRAdditional.h
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/14.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JRAdditional)

- (NSString *)md5_32bit;

//转码方法
-(NSString*)URLDecodedString;

/*
 **
 *  URLEncode
 */
- (NSString *)URLEncodedString;

@end

NS_ASSUME_NONNULL_END
