//
//  SportsTopViewController.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//  

#import "YDQBaseViewController.h"

@interface YDQSportsTopViewController : YDQBaseViewController

/// 向上滑动回调
@property(nonatomic, copy) void (^slidUpCallBack)(SportsType type);

/// 获取当前的运动类型
- (SportsType)getCurrentSportType;

@end
