//
//  UIViewController+SYNavigationController.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/13.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIViewController+SYNavigationController.h"
#import <objc/runtime.h>
#import "SYNavigationController.h"

@interface UIViewController ()

@property (nonatomic, copy) void (^ buttonClickBlock)(UIBarButtonItem *item);

@end

@implementation UIViewController (SYNavigationController)

#pragma mark - setter/getter

@dynamic sy_disableInteractivePop;

- (void)setSy_disableInteractivePop:(BOOL)sy_disableInteractivePop
{
    objc_setAssociatedObject(self, @selector(sy_disableInteractivePop), @(sy_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sy_disableInteractivePop
{
    return [objc_getAssociatedObject(self, @selector(sy_disableInteractivePop)) boolValue];
}

- (Class)sy_navigationBarClass
{
    return nil;
}

- (SYNavigationController *)sy_navigationController
{
    UIViewController *vc = self;
    while (vc && ![vc isKindOfClass:[SYNavigationController class]])
    {
        vc = vc.navigationController;
    }
    return (SYNavigationController *)vc;
}

- (void)setButtonClickBlock:(void (^)(UIBarButtonItem *))buttonClickBlock
{
    objc_setAssociatedObject(self, @selector(buttonClickBlock), buttonClickBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIBarButtonItem *))buttonClickBlock
{
    return objc_getAssociatedObject(self, @selector(buttonClickBlock));
}

#pragma mark - 方法

- (UIBarButtonItem *)barButtonItemWithTarget:(id)target action:(SEL)action
{
    UIBarButtonItem *item = [self barButtonItemWithTitle:@"Back" target:target action:action];
    return item;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:action];
    return item;
}

- (UIBarButtonItem *)barButtonItemAction:(void (^)(UIBarButtonItem *item))action
{
    UIBarButtonItem *item = [self barButtonItemWithTitle:@"Back" action:action];
    return item;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title action:(void (^)(UIBarButtonItem *item))action
{
    if (action)
    {
        self.buttonClickBlock = [action copy];
    }
    UIBarButtonItem *item = [self barButtonItemWithTitle:title target:self action:@selector(buttonClick:)];
    return item;
}

- (void)buttonClick:(UIBarButtonItem *)item
{
    if (self.buttonClickBlock)
    {
        self.buttonClickBlock(item);
    }
}

#pragma mark 导航栏样式

- (void)navigationStyleWithBackgroundColor:(UIColor *)bgColor buttonColor:(UIColor *)btnColor titleColor:(UIColor *)txtColor titleFont:(UIFont *)txtFont
{
    // 使用 RTRootNavigationController 设置具有动画push效果（原生的则是突然变化）
    self.navigationController.navigationBar.translucent = NO;
    
    // 导航栏背景颜色
    if (bgColor)
    {
        self.navigationController.navigationBar.barTintColor = bgColor;
    }
    
    // 导航栏按钮颜色
    if (btnColor)
    {
        self.navigationController.navigationBar.tintColor = btnColor;
    }
    
    // 导航栏标题字体颜色
    if (txtColor)
    {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:txtColor}];
    }
    // 导航栏标题字体大小
    if (txtFont)
    {
        self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:txtFont};
    }
}


@end
