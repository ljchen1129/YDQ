//
//  UIViewController+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIViewController+SYHelper.h"
#import <objc/runtime.h>

static NSString *const keyNavigationItemTitle = @"keyNavigationItemTitle";

// 自定义左右导航栏按钮大小
static CGFloat const sizeButton = 20.0;
//static CGFloat const sizeButton = 15.0;

// 高度设置 20 44 64
static CGFloat const heightStatusbar = 20.0;
static CGFloat const heightNavigationbar = 44.0;
static CGFloat const heightStatusAndNavbar = 64.0;
#define widthScreen  [UIScreen mainScreen].applicationFrame.size.width
#define heightScreen [UIScreen mainScreen].applicationFrame.size.height

@implementation UIViewController (SYHelper)

/// 是否是根视图
- (BOOL)isRootController
{
    if ([self.navigationController.viewControllers.firstObject isEqual:self])
    {
        return YES;
    }

    return NO;
}

#pragma mark - 导航栏设置

#pragma mark 返回上层视图响应

/// 返回上层视图响应
- (void)backPreviousController
{
    if ([self isRootController])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        if (self.presentedViewController)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark 导航栏标题

/// 设置导航栏标题视图
- (void)setNavigationTitleView:(UIView *)titleView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, titleView.clj_width, titleView.clj_height)];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleView.autoresizesSubviews = YES;
    self.navigationItem.titleView = view;
    
    titleView.center = view.center;
    [view addSubview:titleView];
}

/// 设置导航栏标题
- (void)setNavigationTitle:(NSString *)title
{
    if ([NSString isNullNSString:title])
    {
        title = @"未设置标题";
    }
    // self.navigationItem.title = title;
    [self setNavigationDefaultFontTitle:title];
}

- (void)setNavigationDefaultFontTitle:(NSString *)title
{
    // 系统方法 张绍裕 20150604
    self.navigationItem.title = title;
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:kFontSizeBold18, NSForegroundColorAttributeName:UIColorHex(0xffffff)};
    
    // 自定义方法
    // UILabel *label = InsertLabel(nil, CGRectMake(0.0, 0.0, 200.0, kNavigationHeight), NSTextAlignmentCenter, title, kFontSizeBold17, UIColorHex(0x000000), NO);
    // self.navigationItem.titleView = label;
}

- (void)setNavigationItemTitle:(NSString *)navigationItemTitle
{
    if (navigationItemTitle)
    {
        objc_setAssociatedObject(self, &keyNavigationItemTitle, navigationItemTitle, OBJC_ASSOCIATION_RETAIN);
        
        self.navigationItem.title = navigationItemTitle;
    }
}

- (NSString *)navigationItemTitle
{
    NSString *object = objc_getAssociatedObject(self, &keyNavigationItemTitle);
    return object;
}

#pragma mark 导航栏按钮

// 设置导航栏左按钮（导航栏返回按钮，不带标题）
- (UIBarButtonItem *)barBackButton
{
    return [self barBackButtonWithImage:[UIImage imageNamed:@"navigationButtonReturn"] title:YES];
}

/// 设置导航栏左按钮（导航栏返回按钮，是否显示标题）
- (UIBarButtonItem *)barBackButton:(BOOL)notTitle
{
    return [self barBackButtonWithImage:[UIImage imageNamed:@"navigationButtonReturn"] title:notTitle];
}

// 导航栏左按钮（导航栏返回按钮，自定义图标，及是否带标题）
- (UIBarButtonItem *)barBackButtonWithImage:(UIImage *)image title:(BOOL)title
{
    UIBarButtonItem *item = [self barBackButtonWithImage:image image:nil title:title];
    return item;
}

// 导航栏左按钮（导航栏返回按钮，自定义图标，及是否带标题）
- (UIBarButtonItem *)barBackButtonWithImage:(UIImage *)imageNormal image:(UIImage *)imageHighlight title:(BOOL)title
{
    CGRect buttonFrame;
    if (ISIOS7)
    {
        // buttonFrame = CGRectMake(0.0, 0.0, sizeButton * image.size.width / image.size.height, sizeButton);
        buttonFrame = CGRectMake(0.0, 0.0, sizeButton * 3, sizeButton); // 重置按钮大小 张绍裕 20150604
    }
    else
    {
        // buttonFrame = CGRectMake(0.0, 0.0, sizeButton * image.size.width / image.size.height + sizeButton, sizeButton);
        buttonFrame = CGRectMake(0.0, 0.0, sizeButton * 3, sizeButton); // 重置按钮大小 张绍裕 20150604
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(backPreviousController) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:imageHighlight forState:UIControlStateHighlighted];
    
    // begin 设置标题 张绍裕 20150604
    
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, (title ? -15.0 : -50.0), 0.0, 0.0);
    if (title)
    {
        NSString *title = @"返回";
        /*
         if (1 == [self.navigationController.viewControllers indexOfObject:self])
         {
         UIViewController *previousVC = [self.navigationController.viewControllers firstObject];
         title = previousVC.navigationItem.title;
         }
         */
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
        button.titleLabel.font = kFontSizeBold14;
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -15.0, 0.0, 0.0);
    }
    
    // end
    
    button.accessibilityLabel = @"back";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

// 设置导航栏左按钮，是否高亮
+ (UIBarButtonItem *)leftBarButtonWithName:(NSString *)name
                                 imageName:(NSString *)imageName
                                heighlight:(BOOL)heighlight
                                    target:(id)target
                                    action:(SEL)action
{
    UIButton *button = [[self class] setleftButton:heighlight title:name image:imageName];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

// 导航栏左按钮，是否高亮
+ (UIButton *)setleftButton:(BOOL)hightlight title:(NSString *)name image:(NSString *)imageName
{
    CGRect buttonFrame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.accessibilityLabel = @"back";
    if (imageName && 0 != imageName.length)
    {
        UIImage *image = [UIImage imageNamed:imageName];
        if (ISIOS7)
        {
            buttonFrame = CGRectMake(0.0, 0.0, sizeButton * image.size.width / image.size.height, sizeButton);
        }
        else
        {
            buttonFrame = CGRectMake(0.0, 0.0, sizeButton * image.size.width / image.size.height + sizeButton, sizeButton);
        }
        [button setImage:image forState:UIControlStateNormal];
    }
    else
    {
        buttonFrame = CGRectMake(0.0, 0.0, 50.0, sizeButton);
    }
    button.frame = buttonFrame;
    
    if (name && ![name isEqualToString:@""])
    {
        [button setTitle:name forState:UIControlStateNormal];
        button.titleLabel.font = kFontSizeBold14;
        [button setTitleColor:kColorWhite forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateDisabled];
    }
    
    if (!hightlight)
    {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    if (ISIOS7)
    {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 0);
    }
    return button;
}

// 设置导航栏右按钮，是否高亮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                 heighlight:(BOOL)heighlight
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *button = [[self class] setRightButton:heighlight title:name image:imageName];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *button = [[self class] setRightButton:YES title:name image:imageName];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (UIButton *)setRightButton:(BOOL)hightlight title:(NSString *)name image:(NSString *)imageName
{
    UIButton *button = [[self class] setRightButton:name image:imageName];
    if (!hightlight)
    {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    return button;
}

+ (UIButton *)setRightButton:(NSString *)name image:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName && ![imageName isEqualToString:@""])
    {
        UIImage *image = [UIImage imageNamed:imageName];
        [button setImage:image forState:UIControlStateNormal];
        
        NSString *images = [NSString stringWithFormat:@"%@_s", imageName];
        UIImage *imageSelected = [UIImage imageNamed:images];
        if (imageSelected)
        {
            [button setImage:imageSelected forState:UIControlStateSelected];
        }
        
        if (ISIOS7)
        {
            button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        else
        {
            button.frame = CGRectMake(0, 0, image.size.width + sizeButton, image.size.height);
        }
    }
    else
    {
        button.frame = CGRectMake(0, 0, 50, sizeButton);
    }
    
    if (name && ![name isEqualToString:@""])
    {
        [button setTitle:name forState:UIControlStateNormal];
        button.titleLabel.font = kFontSizeBold14;
        [button setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateDisabled];
    }
    
    if (ISIOS7)
    {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    }
    
    return button;
}

@end
