//
//  SportsBottomViewController.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQBaseViewController.h"

@interface YDQSportsBottomViewController : YDQBaseViewController

/// 向下点击回调
@property(nonatomic, copy) void (^slidDown)(void);

/// 运动类型
@property(nonatomic, assign) SportsType sportsType;

@end
