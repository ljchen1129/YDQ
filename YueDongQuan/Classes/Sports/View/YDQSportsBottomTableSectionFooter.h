//
//  YDQSportsBottomTableSectionFooter.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/31.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const YDQSportsBottomTableSectionFooterIndentifierId = @"YDQSportsBottomTableSectionFooterIndentifierId";
static CGFloat const YDQSportsBottomTableSectionFooterHeight = 41.0;

@interface YDQSportsBottomTableSectionFooter : UITableViewHeaderFooterView

+ (instancetype)footerWithTableView:(UITableView *)tableView;

/// footer 标题
@property(nonatomic, copy) NSString *title;


/// footer点击回调
@property(nonatomic, copy) void (^footerClick)(NSString *footerTitle);

@end
