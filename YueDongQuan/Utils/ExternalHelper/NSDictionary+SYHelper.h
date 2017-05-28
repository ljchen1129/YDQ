//
//  NSDictionary+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/2/15.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SYHelper)

#pragma mark - 异常判断

/// 是否是字典判断
- (BOOL)isNSDictionary;

/// 非空字典判断
+ (BOOL)isValidNSDictionary:(NSDictionary *)dictionary;

@end
