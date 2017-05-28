//
//  UserDefaultManager.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-7-17.
//  功能描述：使用NSUserDefault进入基本数据存储操作
//

#import <Foundation/Foundation.h>

@interface SYUserDefaultManager : NSObject

/************************************************************************/

/// 启动应用时，保存定位的经度
+ (void)Savelocationlongitude:(CGFloat)longitude;

/// 启动应用时，保存定位的纬度
+ (void)Savelocationlatitude:(CGFloat)latitude;

/// 获取保存的经度
+ (CGFloat)Getlocationlongitude;

/// 获取保存的纬度
+ (CGFloat)Getlocationlatitude;

/************************************************************************/

/// 是否首次使用定位
+ (void)SavelocationStatusUsing;

/// 获取定位使用状态
+ (BOOL)GetlocationStatusUsing;

/************************************************************************/

/// 启动应用时，是否首次使用
+ (void)SaveAppStatusUsing;

/// 获取保存的首次使用状态
+ (BOOL)GetAppStatusUsing;

/************************************************************************/

/// 保存用户帐号
+ (void)SavelastUserAccount:(NSString *)account;

/// 获取用户帐号
+ (NSString *)GetlastUserAccount;

/************************************************************************/

/// 保存搜索历史记录
+ (void)SaveSearchWords:(NSArray *)words;

/// 获取搜索历史记录
+ (NSArray *)GetSearchWords;

/************************************************************************/

/// 保存当前tabbar视图索引
+ (void)SaveTabbarTargetIndex:(NSInteger)tabbarIndex;

/// 获取最后一个tabbar视图索引
+ (NSInteger)GetTabbarTargetIndex;

/************************************************************************/

/// 保存自动登录开关状态
+ (void)SaveAutoLoginState:(BOOL)isAuto;

/// 获取自动登录开关状态
+ (BOOL)GetAutoLoginState;

/************************************************************************/

/// 保存极光推送消息数量
+ (void)SaveJPushMessageNumber:(NSNumber *)number;

/// 获取极光推送消息数量
+ (NSNumber *)GetJPushMessageNumber;

/************************************************************************/

/// 保存极光推送消息启动APP
+ (void)SaveRemoteNotification:(NSDictionary *)dict;

/// 获取极光推送消息启动APP
+ (NSDictionary *)GetRemoteNotification;

/// 移除极光推送消息启动APP
+ (void)RemoveRemoteNotification;

/************************************************************************/



@end
