//
//  NSTimer+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/2/15.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSTimer+SYHelper.h"

@implementation NSTimer (SYHelper)

/// 开启定时器
- (void)startTimer
{
    [self setFireDate:[NSDate distantPast]];
}

/// 关闭定时器
- (void)stopTimer
{
    [self setFireDate:[NSDate distantFuture]];
}

/// 永久停止定时器
- (void)killTimer
{
    [self stopTimer];
    [self invalidate];
}


@end
