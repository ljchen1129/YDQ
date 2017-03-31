//
//  YDQSportsBottomTableSectionHeader.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/31.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const YDQSportsBottomTableSectionHeaderIndentifierId = @"YDQSportsBottomTableSectionHeaderIndentifierId";
static CGFloat const YDQSportsBottomTableSectionHeaderHeight = 50.0;

@interface YDQSportsBottomTableSectionHeader : UITableViewHeaderFooterView

+ (instancetype)headerWithTableView:(UITableView *)tableView;

/// section 标题
@property(nonatomic, copy) NSString *title;

@end
