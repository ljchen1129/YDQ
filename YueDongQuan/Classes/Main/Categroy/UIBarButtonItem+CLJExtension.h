//
//  UIBarButtonItem+YDQExtension.h
//  Baisibudejie
//
//  Created by 陈良静 on 2017/3/3.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YDQExtension)

/// 创建 UIBarButtonItem 实例
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
