//
//  HUDManager.h
//  DemoHUD
//
//  Created by zhangshaoyu on 14-10-28.
//  Copyright (c) 2014年 ygsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

// 导入头文件
#import <MBProgressHUD/MBProgressHUD.h>

// 设置协议
@interface HUDManager : NSObject <MBProgressHUDDelegate>

/// 设置方法
+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)autoEnabled message:(NSString *)aMessage;

/// 隐藏
+ (void)hiddenHUD;

@end
