//
//  MD5Encryption.h
//  DemoMD5
//
//  Created by zhangshaoyu on 14-11-13.
//  Copyright (c) 2014年 ygsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encryption : NSObject

/**
 *  md5加密字符串
 *
 *  @param text        加密源字符串
 *  @param is32Bit     区分32位，或16位
 *  @param isUppercase 区分大写，或小写
 *
 *  @return md5加密后字符串
 */
+ (NSString *)getMd5WithText:(NSString *)text bit32:(BOOL)is32Bit uppercase:(BOOL)isUppercase;

@end
