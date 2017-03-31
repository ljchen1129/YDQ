//
//  YDQSportsBottomSportsDataCell.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//  运动数据cell

#import <UIKit/UIKit.h>

static CGFloat const YDQSportsBottomSportsDataCellHeight = 210.0;
static NSString *const YDQSportsBottomSportsDataCellIdentifierId = @"YDQSportsBottomSportsDataCellIdentifierId";

@interface YDQSportsBottomSportsDataCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;

/// 运动数据点击回调
@property(nonatomic, copy) void (^sportsDataBtnClick)(void);

@end
