//
//  NSArray+Log.m
//  Baisibudejie
//
//  Created by 陈良静 on 2017/3/4.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *mString = [NSMutableString string];
    // 开头有个[
    [mString appendString:@"[\n"];
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mString appendFormat:@"\t%@,\n" ,obj];
    }];
    
    // 结尾有个]
    [mString appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [mString rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    {
        [mString deleteCharactersInRange:range];
    }
    
    return mString;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *mString = [NSMutableString string];
    // 开头有个{
    [mString appendString:@"{\n"];
    // 遍历所有的元素
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [mString appendFormat:@"\t%@ : %@,\n" ,key, obj];
    }];
    
    // 结尾有个}
    [mString appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [mString rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    {
        [mString deleteCharactersInRange:range];
    }
    
    return mString;
}

@end
