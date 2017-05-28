//
//  UITableView+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/18.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITableView+SYHelper.h"

@implementation UITableView (SYHelper)

/// 设置列表视图cell分割线缩进样式
- (void)setTableViewCellSeparatorInset:(UIEdgeInsets)insets
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        self.separatorInset = insets;
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        self.layoutMargins = insets;
    }
}

@end
