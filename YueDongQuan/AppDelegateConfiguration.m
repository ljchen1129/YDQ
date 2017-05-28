//
//  AppDelegateConfiguration.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/5/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "AppDelegateConfiguration.h"
#import "SYNetworkEnvironment.h"

@implementation AppDelegateConfiguration

/// 配置
+ (void)Configuration
{
    /// 网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    /// 键盘
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = IQKeyboardDistanceFromTextField;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    // 初始化网络
    NetworkRequestEnvironment.titleColorNormal = kColorBlack;
    NetworkRequestEnvironment.titleColorHlight = kColorDarkgray;
    NetworkRequestEnvironment.bgColor = UIColorHex_Alpha(0xffffff, 0.2);
    NetworkRequestEnvironment.networkServiceDebug = @"https://api.51yund.com";
    NetworkRequestEnvironment.networkServiceRelease = @"https://api.51yund.com";
    
    [NetworkRequestEnvironment initializeNetworkEnvironment];
}

@end
