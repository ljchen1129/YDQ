//
//  FMDBHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/30.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYFMDBManager.h"

static NSString *const dataName = @"SYFMDB.db";

@interface SYFMDBManager ()

@property (nonatomic, strong) NSString *dataPath;     // 数据库文件目录
@property (nonatomic, strong) LKDBHelper *dataHelper; // 数据库

@end

@implementation SYFMDBManager

#pragma mark - 实例化

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        NSString *documentDirectory = [paths objectAtIndex:0];
//        self.dataPath = [documentDirectory stringByAppendingPathComponent:dataName];
        
        // 区分每个用户数据库
        NSString *userId = @"";
        NSString *userDBName = [NSString stringWithFormat:@"%@%@", userId, dataName];
        self.dataHelper = [[LKDBHelper alloc] initWithDBName:userDBName];
    }
    
    return self;
}

- (void)dealloc
{
    self.dataPath = nil;
    self.dataHelper = nil;
}

/// 单例
+ (SYFMDBManager *)shareFMDB
{
    static SYFMDBManager *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    
    return sharedManager;
}

#pragma mark - 表操作

// 创建表
- (void)createTable:(Class)modelClass
{
    if (modelClass)
    {
//        BOOL isResult = [self.dataHelper getTableCreatedWithClass:modelClass];
        BOOL isResult = [self.dataHelper createTableWithModelClass:modelClass];
        
        NSString *resultStr = [NSString stringWithFormat:@"创建表(%@)%@", NSStringFromClass(modelClass), (isResult ? @"成功" : @"失败")];
        NSLog(@"%@", resultStr);
    }
}

// 删除表
- (BOOL)dropTable:(Class)modelClass
{
    if (modelClass)
    {
        BOOL isResult = [self.dataHelper dropTableWithClass:modelClass];
        
        NSString *resultStr = [NSString stringWithFormat:@"删除表(%@)%@", NSStringFromClass(modelClass), (isResult ? @"成功" : @"失败")];
        NSLog(@"%@", resultStr);
        
        return isResult;
    }
    
    return NO;
}

// 删除表-block
- (void)dropTable:(Class)modelClass complete:(void (^)(BOOL isSuccess))complete
{
    if (modelClass)
    {
        BOOL isResult = [self.dataHelper dropTableWithClass:modelClass];
        
        NSString *resultStr = [NSString stringWithFormat:@"删除表(%@)%@", NSStringFromClass(modelClass), (isResult ? @"成功" : @"失败")];
        NSLog(@"%@", resultStr);
        
        if (complete)
        {
            complete(isResult);
        }
        
        return;
    }
    
    if (complete)
    {
        complete(NO);
    }
}


// 删除所有表
- (void)dropAllTable
{
    [self.dataHelper dropAllTable];
}

#pragma mark - 数据操作

// 保存数据
- (BOOL)saveDataWithData:(NSObject *)model
{
    if (model)
    {
        // 先删除，后保存
        [self deleteDataWithData:model];
        BOOL isResult = [self.dataHelper insertWhenNotExists:model];
        NSString *resultStr = [NSString stringWithFormat:@"保存数据%@", (isResult ? @"成功" : @"失败")];
        NSLog(@"%@", resultStr);
        
        return isResult;
    }
    
    return NO;
}

// 保存数据-block
- (void)saveDataWithData:(NSObject *)model complete:(void (^)(BOOL isSuccess))complete
{
    if (model)
    {
        [self.dataHelper insertWhenNotExists:model callback:^(BOOL result) {
            if (complete)
            {
                complete(result);
            }
        }];
        
        return;
    }
    
    if (complete)
    {
        complete(NO);
    }
}

// 更新数据
- (BOOL)updateDataWithData:(NSObject *)model
{
    if (model)
    {
        BOOL isResult = [self.dataHelper updateToDB:model where:nil];
        NSString *resultStr = [NSString stringWithFormat:@"更新数据%@", (isResult ? @"成功" : @"失败")];
        NSLog(@"%@", resultStr);
        
        return isResult;
    }
    
    return NO;
}

// 更新数据-block
- (void)updateDataWithData:(NSObject *)model complete:(void (^)(BOOL isSuccess))complete
{
    if (model)
    {
        [self.dataHelper updateToDB:model where:nil callback:^(BOOL result) {
            if (complete)
            {
                complete(result);
            }
        }];
        
        return ;
    }
    
    if (complete)
    {
        complete(NO);
    }
}

// 获取所有数据
- (NSArray *)getAllDataWithClass:(Class)modelClass
{
    NSArray *array = [self getDataWithClass:modelClass where:nil];
    return array;
}

// 获取所有数据-block
- (void)getAllDataWithClass:(Class)modelClass complete:(void (^)(BOOL isSuccess))complete
{
    [self getAllDataWithClass:modelClass where:nil complete:complete];
}

// 获取指定数据
- (NSArray *)getDataWithClass:(Class)modelClass where:(NSString *)where
{
    if (modelClass)
    {
        NSMutableArray *array = [self.dataHelper search:modelClass where:where orderBy:nil offset:0 count:1000];
        return array;
    }
    
    return nil;
}

// 获取指定数据-block
- (void)getAllDataWithClass:(Class)modelClass where:(NSString *)where complete:(void (^)(BOOL isSuccess))complete
{
    if (modelClass)
    {
        [self.dataHelper search:modelClass where:where orderBy:nil offset:0 count:1000 callback:^(NSMutableArray *array) {
            if (complete)
            {
                complete(array);
            }
        }];
        
        return;
    }
    
    if (complete)
    {
        complete(nil);
    }
}

// 删除数据
- (BOOL)deleteDataWithData:(NSObject *)model
{
    if (model)
    {
        BOOL isExit = [self.dataHelper isExistsModel:model];
        if (isExit)
        {
            BOOL isResult = [self.dataHelper deleteToDB:model];
            
            NSString *resultStr = [NSString stringWithFormat:@"删除数据%@", (isResult ? @"成功" : @"失败")];
            NSLog(@"%@", resultStr);
            
            return isResult;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

// 删除数据-block
- (void)deleteDataWithData:(NSObject *)model complete:(void (^)(BOOL isSuccess))complete
{
    if (model)
    {
        BOOL isExit = [self.dataHelper isExistsModel:model];
        if (isExit)
        {
            [self.dataHelper deleteToDB:model callback:^(BOOL result) {
                if (complete)
                {
                    complete(result);
                }
            }];
            
            return ;
        }
        else
        {
            if (complete)
            {
                complete(NO);
            }
            
            return ;
        }
    }
    
    if (complete)
    {
        complete(NO);
    }
}

// 删除所有数据
- (BOOL)deleteAllData
{
    BOOL isResult = [self.dataHelper deleteToDB];
    
    NSString *resultStr = [NSString stringWithFormat:@"删除所有数据%@", (isResult ? @"成功" : @"失败")];
    NSLog(@"%@", resultStr);
    
    return isResult;
}

// 删除所有数据-block
- (void)deleteAllData:(void (^)(BOOL isSuccess))complete
{
    BOOL isResult = [self deleteAllData];
 
    if (complete)
    {
        complete(isResult);
    }
}

@end
