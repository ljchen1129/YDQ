//
//  NSTimer+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/2/15.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SYHelper)

/// 开启定时器
- (void)startTimer;

/// 关闭定时器
- (void)stopTimer;

/// 永久停止定时器
- (void)killTimer;

@end
