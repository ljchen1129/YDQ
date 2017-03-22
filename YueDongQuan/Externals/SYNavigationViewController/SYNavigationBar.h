//
//  SYNavigationBar.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/13.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  github：https://github.com/potato512/SYNavigationViewController

#import <UIKit/UIKit.h>

@interface SYNavigationBar : UINavigationBar

@end

/*
 使用说明
 1、重写方法""，以设置导航栏背景样式
 - (Class)sy_navigationBarClass
 {
     return [SYNavigationBar class];
 }
 
 2、重写方法""，以设置状态栏字体样式
 - (UIStatusBarStyle)preferredStatusBarStyle
 {
     // 黑色字体UIStatusBarStyleDefault、白色字体UIStatusBarStyleLightContent
     return UIStatusBarStyleDefault;
 }
 
*/