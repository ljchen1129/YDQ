//
//  SportsTopContentView.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageContentViewDelegate <NSObject>

/**
    scroll滑动代理

 @param pageContentView 类实例
 @param sourceIndex 起始索引
 @param targetIndex 目标索引
 @param progress 滑动进度
 @param isSuccesed 是否成功滑过去
 */
- (void)pageContentView:(UIView *)pageContentView ScrollSourceIndex:(int)sourceIndex targetIndex:(int)targetIndex progress:(CGFloat)progress isSuccesed:(BOOL)isSuccesed;

@end

@interface YDQMainPageContentView : UIView

/// 代理
@property(nonatomic, weak) id<PageContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray <UIViewController *>*)childVcs parnentVc:(UIViewController *)parnentVc;

/// 设置当前的索引
- (void)setCurrentIndex:(int)index;

@end
