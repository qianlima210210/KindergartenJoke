//
//  NSString+JRAdditional.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/14.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "NSString+JRAdditional.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (JRAdditional)

- (NSString *)md5_32bit {
    //传入参数,转化成char
    const char * str = [self UTF8String];
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char md[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(str, (int)strlen(str), md);
    //创建一个可变字符串收集结果
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        /**
         X 表示以十六进制形式输入/输出
         02 表示不足两位，前面补0输出；出过两位不影响
         printf("%02X", 0x123); //打印出：123
         printf("%02X", 0x1); //打印出：01
         */
        [ret appendFormat:@"%02X",md[i]];
    }
    //返回一个长度为32的字符串
    return ret;
}

//转码方法
-(NSString*)URLDecodedString
{
    NSString*decodedString=(__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

/*
 **
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}


@end
