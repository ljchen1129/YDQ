//
//  YDQSportsBottomBodyWeightCell.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//  体重/体脂cell

#import <UIKit/UIKit.h>

static CGFloat const YDQSportsBottomBodyWeightCellHeight = 200.0;
static NSString *const YDQSportsBottomBodyWeightCellIdentifierId = @"YDQSportsBottomBodyWeightCellIdentifierId";

@interface YDQSportsBottomBodyWeightCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;

/// 体重管理点击回调
@property(nonatomic, copy) void (^goWeightManagerClick)(void);

@end
