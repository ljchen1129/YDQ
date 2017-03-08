//
//  UIView+CLJExtension.h
//  Baisibudejie
//
//  Created by 陈良静 on 2017/3/3.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CLJExtension)

@property(nonatomic, assign) CGFloat clj_width;
@property(nonatomic, assign) CGFloat clj_height;
@property(nonatomic, assign) CGFloat clj_x;
@property(nonatomic, assign) CGFloat clj_y;
@property(nonatomic, assign) CGSize clj_size;

/*
 注意：在分类里面写@property属性，只会生成方法的声明，而不会生成方法的实现以及成员变量
 */

@end
