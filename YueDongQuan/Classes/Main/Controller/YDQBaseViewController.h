//
//  YDQBaseViewController.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDQBaseViewController : UIViewController

/// 返回上层视图方法
- (void)backPreviousController;

/**
 *  首页导航栏视图控制器样式
 */
- (void)navigationControllerStyleFirst;

/**
 *  非首页导航栏视图控制器样式
 */
- (void)navigationControllerStyleSecond;

#pragma mark - 网络状态

/// 开始（动态图）
- (void)loadingStart;

/// 开始（动态图，或菊花转）
- (void)loadingStartWithImages:(NSArray *)images;

/// 开始（自定义）
- (void)loadingStartCustom:(NSString *)message image:(UIImage *)image;

/// 结束，加载成功
- (void)loadedSueccess;

/// 结束，加载成功，无数据
- (void)loadedSuccessWithoutData:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败,默认文字图片
-(void)loadedFailue;

/// 结束，加载失败
- (void)loadedFailue:(NSString *)message image:(UIImage *)image;

/// 结束，加载失败（重新加载）
- (void)loadedFailueAndRestart:(NSString *)message image:(UIImage *)image restart:(void (^)(void))restartClick;

#pragma mark - 网络请求

/// 刷新代理方法
-(void)refreshClick;

/// 加载数据方法
- (void)loadData;

/// 加载数据方法（是否首次加载）
- (void)loadData:(BOOL)isFirst;

/// 加载数据方法，分页
- (void)loadDataWithPage:(int)page;

/// 加载数据方法，分页（是否首次加载）
- (void)loadDataWithPage:(int)page loadFirst:(BOOL)isFirst;

/// 加载更多数据方法
- (void)loadMoreData;

///// 添加网络操作，便于释放
//- (void)addNet:(MKNetworkOperation *)net;

/// 释放网络
- (void)releaseNet;

/// 释放网络
- (void)releaseNetWithTarget:(id)target;

#pragma mark - 登录状态

/// 判断登录，延迟改变tabbar视图
- (void)loginVerifySuccess:(void (^)())success;

/// 判断登录，是否立即，或延迟变更tabbar视图（延迟时，在返回最顶层时改变）
- (void)loginVerify:(BOOL)changTabNow success:(void (^)(void))success;

@end
