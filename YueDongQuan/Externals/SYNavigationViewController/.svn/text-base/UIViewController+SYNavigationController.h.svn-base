//
//  UIViewController+SYNavigationController.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/13.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  github：https://github.com/potato512/SYNavigationViewController

#import <UIKit/UIKit.h>

@class SYNavigationController;

IB_DESIGNABLE
@interface UIViewController (SYNavigationController)

/*!
 *  @brief set this property to @b YES to disable interactive pop
 */
@property (nonatomic, assign) IBInspectable BOOL sy_disableInteractivePop;

/*!
 *  @brief @c self\.navigationControlle will get a wrapping @c UINavigationController, use this property to get the real navigation controller
 */
@property (nonatomic, readonly, strong) SYNavigationController *sy_navigationController;

/*!
 *  @brief Override this method to provide a custom subclass of @c UINavigationBar, defaults return nil
 *
 *  @return new UINavigationBar class
 */
- (Class)sy_navigationBarClass;

/**
 *  UIBarButtonItem实例化
 *
 *  @param target 响应对象
 *  @param action 响应事件
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action;

/**
 *  UIBarButtonItem实例化
 *
 *  @param title  按钮标题
 *  @param target 响应对象
 *  @param action 响应事件
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  UIBarButtonItem实例化
 *
 *  @param action 响应事件回调
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)barButtonItemAction:(void (^)(UIBarButtonItem *item))action;

/**
 *  UIBarButtonItem实例化
 *
 *  @param title  按钮标题
 *  @param action 响应事件回调
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title action:(void (^)(UIBarButtonItem *item))action;

/**
 *  导航栏样式设置
 *
 *  @param bgColor  导航栏背景颜色
 *  @param btnColor 导航栏按钮标题字体颜色
 *  @param txtColor 导航栏标题字体颜色
 *  @param txtFont  导航栏标题字体大小
 */
- (void)navigationStyleWithBackgroundColor:(UIColor *)bgColor
                               buttonColor:(UIColor *)btnColor
                                titleColor:(UIColor *)txtColor
                                 titleFont:(UIFont *)txtFont;


@end
