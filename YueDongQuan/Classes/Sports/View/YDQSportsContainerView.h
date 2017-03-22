//
//  SportsMainCollectionView.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDQSportsContainerView : UIView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray <UIViewController *>*)childVcs parnentVc:(UIViewController *)parnentVc;

/// 设置当前的索引
- (void)setCurrentIndex:(int)index;

/// 上滑响应回调
@property(nonatomic, copy) void (^slidUpCallBack)(SportsType type);

@end
