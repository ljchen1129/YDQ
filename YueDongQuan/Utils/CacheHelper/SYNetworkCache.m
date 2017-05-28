//
//  MKNetworkCache.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/12/29.
//  Copyright © 2015年 zhangshaoyu. All rights reserved.
//

#import "SYNetworkCache.h"
#import <CommonCrypto/CommonDigest.h>
#import "SYFMDBManager.h"

@interface SYNetworkCache ()

@end

@implementation SYNetworkCache

// 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[SYFMDBManager shareFMDB] createTable:[SYNetworkCache class]];
    }
    
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - 单例

// 单例
+ (SYNetworkCache *)shareCache
{
    static SYNetworkCache *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    
    return sharedManager;
}

#pragma mark - 数据缓存

/// 缓存数据
- (void)saveNetworkCacheData:(NSData *)responseData cachekey:(NSString *)urlKey cacheTime:(NSTimeInterval)expiresInSeconds
{
    SYNetworkCache *downloadCache = [[SYNetworkCache alloc] init];
    downloadCache.cacheKey = urlKey;
    downloadCache.cacheDate = [NSDate date];
    downloadCache.cacheValiditySeconds = [NSNumber numberWithDouble:expiresInSeconds];
    downloadCache.cacheData = responseData;
    downloadCache.cacheOverdueDate = [[NSDate date] dateByAddingTimeInterval:expiresInSeconds];
    
    // 保存
    [[SYFMDBManager shareFMDB] saveDataWithData:downloadCache];
}

#pragma mark - 数据读取

/// 获取指定缓存数据
- (NSData *)getNetworkCacheContentWithCacheKey:(NSString *)urlKey
{
    if (urlKey)
    {
        SYNetworkCache *cache;

        NSArray *array = [[SYFMDBManager shareFMDB] getAllDataWithClass:[SYNetworkCache class]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cacheKey == %@",urlKey];
        NSArray *results = [array filteredArrayUsingPredicate:predicate];
        cache = results.firstObject;
        
        NSDate *expiryDate = cache.cacheOverdueDate;
        
        // 存储的数据已过期
        NSComparisonResult compareResult = [[NSDate date] compare:expiryDate];
        if (NSOrderedDescending == compareResult)
        {
            // 删除过期数据
            [self deleteNetworkCacheWithKey:urlKey];
            
            return nil;
        }
        
        NSData *content = cache.cacheData;
        return content;
    }
    
    return nil;
}

#pragma mark - 数据清除

/// 清除指定的数据
- (void)deleteNetworkCacheWithKey:(NSString *)urlKey
{
    if (urlKey == nil)
    {
        return;
    }
    
    SYNetworkCache *cache;
    NSArray *array = [[SYFMDBManager shareFMDB] getAllDataWithClass:[SYNetworkCache class]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cacheKey == %@",urlKey];
    NSArray *results = [array filteredArrayUsingPredicate:predicate];
    cache = results.firstObject;
    
    [[SYFMDBManager shareFMDB] deleteDataWithData:cache];
}

/// 清除内存
- (void)networkCacheClearMemory
{
    // won't be able to complete
}

/// 清除所有的缓存
- (void)networkCacheClearAll
{
    [[SYFMDBManager shareFMDB] deleteAllData];
}

/// 计算缓存数据库文件大小
- (NSString *)networkCacheSize
{
    NSUInteger size = 0;
    NSArray *array = [[SYFMDBManager shareFMDB] getAllDataWithClass:[SYNetworkCache class]];
    for (SYNetworkCache *model in array)
    {
        NSData *cacheData = model.cacheData;
        NSUInteger cacheSize = cacheData.length;
        size += cacheSize;
    }
    
    NSString *sizeStr = [NSString stringWithFormat:@"%ldB", size];
    if (size > 1024 * 1024)
    {
        size = size / 1024 * 1024;
        sizeStr = [NSString stringWithFormat:@"%ldM", size];
    }
    else if (size > 1024)
    {
        size = size / 1024;
        sizeStr = [NSString stringWithFormat:@"%ldKB", size];
    }
    
    return sizeStr;
}

/// 清除缓存（是否删除表）
- (void)networkCacehClear:(BOOL)dropTable
{
    [[SYFMDBManager shareFMDB] deleteAllData:^(BOOL isSuccess) {
        if (dropTable)
        {
            [[SYFMDBManager shareFMDB] dropTable:[SYNetworkCache class]];
        }
    }];
}

@end
