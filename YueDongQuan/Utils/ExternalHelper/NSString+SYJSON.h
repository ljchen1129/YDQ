//
//  NSString+SYJSON.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/6/2.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYJSON)

/// dict字典转json字符串
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict;

/// json字符串转dict字典
+ (NSDictionary *)jsonDictWithString:(NSString *)string;

@end
