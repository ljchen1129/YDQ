//
//  FMDBHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/30.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//  数据库操作管理
/*
 使用说明
 1 关联第三方库
 1-1 FMDB
 1-2 LKDBHelper
 
*/

#import <Foundation/Foundation.h>
#import <LKDBHelper/LKDBHelper.h>

@interface SYFMDBManager : NSObject

/// 单例
+ (SYFMDBManager *)shareFMDB;

#pragma mark - 表操作

/// 创建表
- (void)createTable:(Class)modelClass;

/// 删除表
- (BOOL)dropTable:(Class)modelClass;

/// 删除表-block
- (void)dropTable:(Class)modelClass complete:(void (^)(BOOL isSuccess))complete;

/// 删除所有表
- (void)dropAllTable;

#pragma mark - 数据操作

/// 保存数据
- (BOOL)saveDataWithData:(NSObject *)model;

/// 保存数据-block
- (void)saveDataWithData:(NSObject *)model complete:(void (^)(BOOL isSuccess))complete;

/// 更新数据
- (BOOL)updateDataWithData:(NSObject *)model;

/// 更新数据-block
- (void)updateDataWithData:(NSObject *)model complete:(void (^)(BOOL isSuccess))complete;

/// 获取所有数据
- (NSArray *)getAllDataWithClass:(Class)modelClass;

/// 获取所有数据-block
- (void)getAllDataWithClass:(Class)modelClass complete:(void (^)(BOOL isSuccess))complete;

/// 获取指定数据
- (NSArray *)getDataWithClass:(Class)modelClass where:(NSString *)where;

/// 获取指定数据-block
- (void)getAllDataWithClass:(Class)modelClass where:(NSString *)where complete:(void (^)(BOOL isSuccess))complete;

/// 删除数据
- (BOOL)deleteDataWithData:(NSObject *)model;

/// 删除数据-block
- (void)deleteDataWithData:(NSObject *)model complete:(void (^)(BOOL isSuccess))complete;

/// 删除所有数据
- (BOOL)deleteAllData;

/// 删除所有数据-block
- (void)deleteAllData:(void (^)(BOOL isSuccess))complete;

@end