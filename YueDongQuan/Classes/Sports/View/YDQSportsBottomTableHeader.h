//
//  YDQSportsBottomTableHearder.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//  bottom 控制器表格视图 header

#import <UIKit/UIKit.h>

static CGFloat const YDQSportsBottomTableHeaderHeight = 130.0;

@interface YDQSportsBottomTableHeader : UIView

/// 向下滑块响应回调
@property(nonatomic, copy) void (^sildDown)(void);

/// 运动按钮响应回调
@property(nonatomic, copy) void (^doSportsCallBack)(SportsType type);

/// 运动类型
@property(nonatomic, assign) SportsType sportsType;

@end

