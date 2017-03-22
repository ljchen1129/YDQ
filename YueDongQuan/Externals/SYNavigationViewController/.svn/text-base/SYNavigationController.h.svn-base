//
//  SYNavigationController.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/13.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  github：https://github.com/potato512/SYNavigationViewController

#import <UIKit/UIKit.h>
#import "SYNavigationBar.h"
#import "UIViewController+SYNavigationController.h"

/******************************************************************************/

#pragma mark - 内容视图控制器

@interface SYContainerController : UIViewController

@property (nonatomic, readonly, strong) __kindof UIViewController *contentViewController;

@end

/******************************************************************************/

#pragma mark - 内容导航视图控制器

@interface SYContainerNavigationController : UINavigationController

@end

/******************************************************************************/

#pragma mark - 导航视图控制器

IB_DESIGNABLE
@interface SYNavigationController : UINavigationController

/**
*  是否使用系统的返回按钮（push出来的视图控制器）（默认NO，即使用自定义）
*/
@property (nonatomic, assign) IBInspectable BOOL showBackBarButtonItem;

/**
 *  是否显示返回按钮（present出来的视图控制器）（默认NO，即不显示）
 */
@property (nonatomic, assign) IBInspectable BOOL showCancelBarButtonItem;

/// 使用根视图控制器导航栏样式（默认YES，即每个视图控制器的导航栏样式与根视图控制器的一致）
@property (nonatomic, assign) IBInspectable BOOL transferNavigationBarAttributes;

/**
 *  可见视图控制器
 */
@property (nonatomic, readonly, strong) UIViewController *sy_visibleViewController;

/**
 *  顶层视图控制器
 */
@property (nonatomic, readonly, strong) UIViewController *sy_topViewController;

/**
 *  视图控制器数组
 */
@property (nonatomic, readonly, strong) NSArray <__kindof UIViewController *> *sy_viewControllers;

/**
 *  初始化导航栏视图控制器
 *
 *  @param rootViewController 根视图控制器
 *
 *  @return 导航栏视图控制器
 */
- (instancetype)initWithRootViewControllerNoWrapping:(UIViewController *)rootViewController;

/**
 *  移除视图控制器
 *
 *  @param controller 被移除的视图控制器
 */
- (void)removeViewController:(UIViewController *)controller NS_REQUIRES_SUPER;
- (void)removeViewController:(UIViewController *)controller animated:(BOOL)flag NS_REQUIRES_SUPER;

/**
 *  推出视图控制器
 *
 *  @param viewController 被推出显示的视图控制器
 *  @param animated       是否动画
 *  @param block          推出时的回调block
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                  complete:(void(^)(BOOL finished))block;

/**
 *  返回到指定的视图控制器
 *
 *  @param viewController 指定回到的视图控制器
 *  @param animated       是否动画
 *  @param block          返回时的回调block
 *
 *  @return 视图控制器数组
 */
- (NSArray <__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                      animated:(BOOL)animated
                                                      complete:(void(^)(BOOL finished))block;

/**
 *  返回到根视图控制器
 *
 *  @param animated 是否动画
 *  @param block    返回时的回调block
 *
 *  @return 视图控制器数组
 */
- (NSArray <__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
                                                                  complete:(void(^)(BOOL finished))block;




@end

/******************************************************************************/

/*
 使用说明
 1、定义根视图
 ViewController *rootVC = [[ViewController alloc] init];
 SYNavigationController *rootNav = [[SYNavigationController alloc] initWithRootViewController:rootVC];
 rootNav.showBackBarButtonItem = YES;
 rootNav.transferNavigationBarAttributes = NO;
 rootVC.showCancelBarButtonItem = YES;
 
 2、修改导航栏样式
 [self navigationStyleWithBackgroundColor:[UIColor brownColor] buttonColor:[UIColor yellowColor] titleColor:[UIColor greenColor] titleFont:[UIFont systemFontOfSize:12.0]];
 
 3、修改状态栏样式
 - (UIStatusBarStyle)preferredStatusBarStyle
 {
     // 黑色字体UIStatusBarStyleDefault、白色字体UIStatusBarStyleLightContent
     return UIStatusBarStyleDefault;
 }
 
 
*/



