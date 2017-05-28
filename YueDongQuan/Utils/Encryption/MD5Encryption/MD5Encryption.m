//
//  MD5Encryption.m
//  DemoMD5
//
//  Created by zhangshaoyu on 14-11-13.
//  Copyright (c) 2014年 ygsoft. All rights reserved.
//

#import "MD5Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Encryption

/**
 *  md5加密字符串
 *
 *  @param text        加密源字符串
 *  @param is32Bit     区分32位，或16位
 *  @param isUppercase 区分大写，或小写
 *
 *  @return md5加密后字符串
 */
+ (NSString *)getMd5WithText:(NSString *)text bit32:(BOOL)is32Bit uppercase:(BOOL)isUppercase
{
    if (is32Bit)
    {
        NSString *result = [self getMd5_32Bit_String:text uppercase:YES];
        
        return result;
    }
    
    NSString *result = [self getMd5_16Bit_String:text uppercase:YES];
    
    return result;
}

// md5 32位加密
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return uppercase ? [result uppercaseString] : result;
}

// md5 16位加密
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase
{
    // 提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString uppercase:uppercase];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8]; // 即9～25位
    
    return result;
}

@end
