//
//  SportsTopViewController.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//  

#import "YDQBaseViewController.h"

/// 运动类型
typedef NS_ENUM(NSUInteger, SportsType)
{
    /// 计步
    SportsTypeByStep = 0,
    /// 跑步
    SportsTypeByRun = 1,
    /// 健身
    SportsTypeByFitness = 2,
    /// 骑行
    SportsTypeByRide = 3
};

@interface YDQSportsTopViewController : YDQBaseViewController

/// 向上滑动回调
@property(nonatomic, copy) void (^slidUpCallBack)(SportsType type);

@end
