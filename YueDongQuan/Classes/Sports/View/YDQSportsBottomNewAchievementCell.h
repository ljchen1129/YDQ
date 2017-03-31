//
//  YDQSportsBottomNewAchievementCell.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
// 新成就cell

#import <UIKit/UIKit.h>

static CGFloat const YDQSportsBottomNewAchievementCellHeight = 100.0;
static NSString *const YDQSportsBottomNewAchievementCellIdentifierId = @"YDQSportsBottomNewAchievementCellIdentifierId";

@interface YDQSportsBottomNewAchievementCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;

@end
