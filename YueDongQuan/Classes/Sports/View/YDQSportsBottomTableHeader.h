//
//  YDQSportsBottomTableHearder.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const YDQSportsBottomTableHeaderHeight = 130.0;
static NSString *const YDQSportsBottomTableHeaderIndetifierId = @"YDQSportsBottomTableHeaderIndetifierId";

@interface YDQSportsBottomTableHeader : UITableViewHeaderFooterView

+ (instancetype)headerWithTableView:(UITableView *)tableView;

/// 向下滑块响应回调
@property(nonatomic, copy) void (^sildDown)(void);

@end
