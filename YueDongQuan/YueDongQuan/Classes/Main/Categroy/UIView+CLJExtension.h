//
//  UIView+CLJExtension.h
//  Baisibudejie
//
//  Created by 陈良静 on 2017/3/3.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CLJExtension)

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGSize size;

/*
 注意：在分类里面写@property属性，只会生成方法的声明，而不会生成方法的实现以及成员变量
 */

@end
