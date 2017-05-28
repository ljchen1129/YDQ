//
//  YDQSportsHeader.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef YDQSportsHeader_h
#define YDQSportsHeader_h

#define YDQSprotsTableCellBg UIColorRGB_Alpha(30,75,99,1.0)

#define YDQSprotsBottomSportsDataCellBg UIColorRGB_Alpha(42,79,99,0.7)
#define YDQSprotsBottomBodyWeightCellBg UIColorRGB_Alpha(65,79,64,0.6)
#define YDQSprotsBottomNewAchievementCellBg UIColorRGB_Alpha(49,80,95,0.5)

/// 按钮背景色
#define YDQButtonBg UIColorRGB(64,194,42)

/// 运动类型
typedef NS_ENUM(NSUInteger, SportsType) {
    /// 计步
    SportsTypeByStep = 0,
    /// 跑步
    SportsTypeByRun = 1,
    /// 健身
    SportsTypeByFitness = 2,
    /// 骑行
    SportsTypeByRide = 3
};

#endif /* YDQSportsHeader_h */
