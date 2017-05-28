//
//  NSArray+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/2/15.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SYHelper)

#pragma mark - 异常判断

/// 是否是数组判断
- (BOOL)isArray;

/// 非空数组判断
+ (BOOL)isValidArray:(NSArray *)array;

#pragma mark - 数组比较排序

/// 数组排序（isAscending=NO 降序；isAscending=YES 升序）
- (NSArray *)sortNumberArrayUsingSelector:(BOOL)isAscending;

/// 数组排序（isAscending=NO 降序；isAscending=YES 升序）
- (NSArray *)sortArrayUsingComparator:(BOOL)isAscending;

/// 数组排序（isAscending=NO 降序；isAscending=YES 升序）
- (NSArray *)sortArrayUsingFunction:(BOOL)isAscending;

/// 数组排序（数组元素也可以是字典。isAscending=NO 降序；isAscending=YES 升序）
- (void)sortArrayWithCondition:(NSString *)condition ascending:(BOOL)isAscending;

#pragma mark - 数组取值，或重组

/**
 *  字符串数组转换成大写字符串数组
 *
 *  @return 大写字符串数组
 */
- (NSArray *)uppercaseArray;

/**
 *  字符串数组转换成每个字符串长度的数组
 *
 *  @return 每个字符串长度数组
 */
- (NSArray *)lengthArray;

/**
 *  NSNumber数组中快速计算数组求和NSNumber
 *
 *  @return NSNumber数组中快速计算数组求和NSNumber
 */
- (NSNumber *)sumObjectInArray;

/**
 *  NSNumber数组中快速计算数组平均数Number
 *
 *  @return NSNumber数组中快速计算数组平均数Number
 */
- (NSNumber *)averageObjectInArray;

/**
 *  NSNumber数组中获取最大值NSNumber
 *
 *  @return NSNumber数组中获取最大值NSNumber
 */
- (NSNumber *)maxObjectInArray;

/**
 *  NSNumber数组中获取最小值NSNumber
 *
 *  @return 获取最小值NSNumber
 */
- (NSNumber *)minObjectInArray;

/**
 *  字符串数组剔除重复数据后的数组
 *
 *  @return 剔除重复数据后的数组
 */
- (NSArray *)distinctArray;

@end
