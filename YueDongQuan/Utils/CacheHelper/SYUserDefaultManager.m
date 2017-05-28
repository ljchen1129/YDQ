//
//  UserDefaultManager.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-7-17.
//
//

#import "SYUserDefaultManager.h"

// 常量定义
#define UserDefault [NSUserDefaults standardUserDefaults]

/************************************************************************/

static NSString *const Keylocationlongitude = @"locationlongitude";
static NSString *const Keylocationlatitude = @"locationlatitude";
static NSString *const KeyloactionStatusUsing = @"KeyloactionStatusUsing";
static NSString *const KeyAppStatusUsing = @"KeyAppStatusUsing";
static NSString *const KeylastUserAccount = @"KeylastUserAccount";
static NSString *const KeySearchWords = @"KeySearchWords";
static NSString *const KeyTabberIndex = @"KeyTabberIndex";
static NSString *const keyAutoLoginState = @"keyAutoLoginState";
static NSString *const keyReceiveJPushMessage = @"keyReceiveJPushMessage";
static NSString *const keyRemoteNotification = @"keyRemoteNotification";

/************************************************************************/

@implementation SYUserDefaultManager

/************************************************************************/

/// 启动应用时，保存定位的经度
+ (void)Savelocationlongitude:(CGFloat)longitude
{
    [UserDefault setObject:[NSNumber numberWithDouble:longitude] forKey:Keylocationlongitude];
    [UserDefault synchronize];
}

/// 启动应用时，保存定位的纬度
+ (void)Savelocationlatitude:(CGFloat)latitude
{
    [UserDefault setObject:[NSNumber numberWithDouble:latitude] forKey:Keylocationlatitude];
    [UserDefault synchronize];
}

/// 获取保存的经度
+ (CGFloat)Getlocationlongitude
{
    NSNumber *number = [UserDefault objectForKey:Keylocationlongitude];
    return number.doubleValue;
}

/// 获取保存的纬度
+ (CGFloat)Getlocationlatitude
{
    NSNumber *number = [UserDefault objectForKey:Keylocationlatitude];
    return number.doubleValue;
}

/************************************************************************/

/// 是否首次使用定位
+ (void)SavelocationStatusUsing
{
    [UserDefault setObject:[NSNumber numberWithBool:YES] forKey:KeyloactionStatusUsing];
    [UserDefault synchronize];
}

/// 获取定位使用状态
+ (BOOL)GetlocationStatusUsing
{
    NSNumber *number = [UserDefault objectForKey:KeyloactionStatusUsing];
    return number.boolValue;
}

/************************************************************************/

/// 启动应用时，保存使用状态，即是否首次使用
+ (void)SaveAppStatusUsing
{
    [UserDefault setObject:[NSNumber numberWithBool:YES] forKey:KeyAppStatusUsing];
    [UserDefault synchronize];
}

/// 获取保存的首次使用状态
+ (BOOL)GetAppStatusUsing
{
    NSNumber *number = [UserDefault objectForKey:KeyAppStatusUsing];
    return number.boolValue;
}

/************************************************************************/

/// 保存用户帐号
+ (void)SavelastUserAccount:(NSString *)account
{
    if (!account || 0 == account.length)
    {
        return;
    }
    
    [UserDefault setObject:account forKey:KeylastUserAccount];
    [UserDefault synchronize];
}

/// 获取用户帐号
+ (NSString *)GetlastUserAccount
{
    NSString *account = [UserDefault objectForKey:KeylastUserAccount];
    return account;
}

/************************************************************************/

/// 保存搜索历史记录
+ (void)SaveSearchWords:(NSArray *)words
{
    if (!words || 0 >= words.count)
    {
        NSArray *array = [[NSArray alloc] init];
        [UserDefault setObject:array forKey:KeySearchWords];
    }
    else
    {
        [UserDefault setObject:words forKey:KeySearchWords];
    }
    
    [UserDefault synchronize];
}

/// 获取搜索历史记录
+ (NSArray *)GetSearchWords
{
    NSArray *words = [UserDefault objectForKey:KeySearchWords];
    return words;
}

/************************************************************************/

/// 保存当前tabbar视图索引
+ (void)SaveTabbarTargetIndex:(NSInteger)tabbarIndex
{
    NSNumber *number = [NSNumber numberWithInteger:tabbarIndex];
    
    [UserDefault setObject:number forKey:KeyTabberIndex];
    [UserDefault synchronize];
}

/// 获取最后一个tabbar视图索引
+ (NSInteger)GetTabbarTargetIndex
{
    NSNumber *indexNumber = [UserDefault objectForKey:KeyTabberIndex];
    NSInteger index = indexNumber.integerValue;

    return index;
}

/************************************************************************/

/// 保存自动登录开关状态
+ (void)SaveAutoLoginState:(BOOL)isAuto
{
    [UserDefault setObject:[NSNumber numberWithBool:isAuto] forKey:keyAutoLoginState];
    [UserDefault synchronize];
}

/// 获取自动登录开关状态
+ (BOOL)GetAutoLoginState
{
    NSNumber *state = [UserDefault objectForKey:keyAutoLoginState];
    return state.boolValue;
}

/************************************************************************/

/// 保存极光推送消息数量
+ (void)SaveJPushMessageNumber:(NSNumber *)number
{
    [UserDefault setObject:number forKey:keyReceiveJPushMessage];
    [UserDefault synchronize];
}

/// 获取极光推送消息数量
+ (NSNumber *)GetJPushMessageNumber
{
    NSNumber *number = [UserDefault objectForKey:keyReceiveJPushMessage];
    return number;
}

/************************************************************************/

/// 保存极光推送消息启动APP
+ (void)SaveRemoteNotification:(NSDictionary *)dict
{
    [UserDefault setObject:dict forKey:keyRemoteNotification];
    [UserDefault synchronize];
}

/// 获取极光推送消息启动APP
+ (NSDictionary *)GetRemoteNotification
{
    NSDictionary *dict = [UserDefault objectForKey:keyRemoteNotification];
    return dict;
}

/// 移除极光推送消息启动APP
+ (void)RemoveRemoteNotification
{
    [UserDefault removeObjectForKey:keyRemoteNotification];
    [UserDefault synchronize];
}

/************************************************************************/

@end
