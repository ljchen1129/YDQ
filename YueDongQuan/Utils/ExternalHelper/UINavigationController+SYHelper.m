//
//  UINavigationController+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/5/20.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UINavigationController+SYHelper.h"

// 高度设置 20 44 64
static CGFloat const heightStatusbar = 20.0;
static CGFloat const heightNavigationbar = 44.0;
static CGFloat const heightStatusAndNavbar = 64.0;
#define widthScreen  [UIScreen mainScreen].applicationFrame.size.width
#define heightScreen [UIScreen mainScreen].applicationFrame.size.height

@implementation UINavigationController (SYHelper)

#pragma mark 导航栏样式

/// 导航栏样式设置
- (void)navigationStyleDefault
{
    [self navigationStyleColor:kColorNavBgroundRed textFont:kFontSize18 textColor:kColorWhite];
}

/// 导航栏样式设置（自定义背景颜色、字体）
- (void)navigationStyleColor:(UIColor *)backgroundColor textFont:(UIFont *)textFont textColor:(UIColor *)textColor
{
    if (ISIOS7)
    {
        // 背景色
        [self.navigationBar setBarTintColor:backgroundColor];
        self.navigationBar.translucent = NO;
        self.navigationBar.tintColor = kColorWhite;
        
        // 字体
        self.navigationBar.titleTextAttributes = @{NSFontAttributeName:textFont, NSForegroundColorAttributeName:textColor};
        
        // 导航底部1px的阴影颜色-修改
        [self.navigationBar setShadowImage:kImageWithColor(kColorSeparatorline)];
        
        // 导航底部1px的阴影-遮住
        /*
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.backgroundColor = kColorSeparatorline.CGColor;
        CGRect maskRect = CGRectMake(0, -heightStatusbar, widthScreen, heightStatusAndNavbar);
        maskLayer.path = CGPathCreateWithRect(maskRect, NULL);
        self.navigationBar.layer.mask = maskLayer;
        */
    }
}

@end
