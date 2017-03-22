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
