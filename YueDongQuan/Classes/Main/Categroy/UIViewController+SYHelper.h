//
//  UIViewController+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SYHelper)

/// 是否是根视图
- (BOOL)isRootController;

/// 返回上层视图响应
- (void)backPreviousController;

/// 设置导航栏标题视图
- (void)setNavigationTitleView:(UIView *)titleView;

/// 导航栏标题
@property (nonatomic, strong) NSString *navigationItemTitle;

// 设置导航栏左按钮（导航栏返回按钮，不带标题）
- (UIBarButtonItem *)barBackButton;
/// 设置导航栏左按钮（导航栏返回按钮，是否显示标题）
- (UIBarButtonItem *)barBackButton:(BOOL)notTitle;
// 导航栏左按钮（导航栏返回按钮，自定义图标，及是否带标题）
- (UIBarButtonItem *)barBackButtonWithImage:(UIImage *)imageNormal image:(UIImage *)imageHighlight title:(BOOL)title;

// 设置导航栏左按钮，是否高亮
+ (UIBarButtonItem *)leftBarButtonWithName:(NSString *)name
                                 imageName:(NSString *)imageName
                                heighlight:(BOOL)heighlight
                                    target:(id)target
                                    action:(SEL)action;

// 设置导航栏右按钮，是否高亮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                 heighlight:(BOOL)heighlight
                                     target:(id)target
                                     action:(SEL)action;

@end
