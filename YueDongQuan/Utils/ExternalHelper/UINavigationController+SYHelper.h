//
//  UINavigationController+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/5/20.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SYHelper)

/// 导航栏样式设置
- (void)navigationStyleDefault;

/// 导航栏样式设置（自定义背景颜色、字体）
- (void)navigationStyleColor:(UIColor *)backgroundColor textFont:(UIFont *)textFont textColor:(UIColor *)textColor;

@end
