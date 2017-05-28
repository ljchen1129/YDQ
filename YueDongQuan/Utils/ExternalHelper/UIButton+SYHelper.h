//
//  UIButton+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/11.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图片与标题显示样式
typedef NS_ENUM(NSInteger, ButtonStyle)
{
    /// 图片与标题显示样式：图片居左，文字居右（默认，水平居中）
    ButtonStyleDefault = 0,
    
    /// 图片与标题显示样式：图片居右，文字居左（水平居中）
    ButtonStyleImageRightTextLeftHorizontalCenter = 1,
    
    /// 图片与标题显示样式：图片居中，文字居中（水平居中，垂直居中）
    ButtonStyleCenter = 2,
    
    /// 图片与标题显示样式：图片居上，文字居下（垂直居中）
    ButtonStyleImageUpTextDownVerticalCenter = 3,
    
    /// 图片与标题显示样式：图片居下，文字居上（垂直居中）
    ButtonStyleImageDownTextUpVerticalCenter = 4,
};

@interface UIButton (SYHelper)

/// 图片与标题显示样式（offset大于0时拉开距离，offset小于0时缩小距离）
- (void)buttonStyle:(ButtonStyle)style offSet:(CGFloat)offset;

@end
