//
//  YDQSportsBottomNomalCell.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const YDQSportsBottomNomalCellHeight = 81.0;
static NSString *const YDQSportsBottomNomalCellIdentifierId = @"YDQSportsBottomNomalCellIdentifierId";

@interface YDQSportsBottomNomalCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;

@end
