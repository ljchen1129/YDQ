//
//  UIAlertView+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/22.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIAlertView+SYHelper.h"

#define isIOS8System ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

typedef void (^DismissBlock)(NSInteger buttonIndex, NSString *buttonTitle);
typedef void (^CancelBlock)(void);
static DismissBlock dismissblock;
static CancelBlock cancelblock;

@implementation UIAlertView (SYHelper)

/// 封装Block（title标题、message信息、cancelButtonTitle/otherButtonTitles按钮、dismisse/cancel响应方法）
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
            controller:(UIViewController *)controller
             onDismiss:(void (^)(int buttonIndex, NSString *buttonTitle))dismisse
              onCancel:(void (^)(void))cancel
{
    if (isIOS8System && controller)
    {
        [[self class] alertWithStyle:UIAlertControllerStyleAlert title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles controller:controller onDismiss:dismisse onCancel:cancel];
    }
    else
    {
        dismissblock = [dismisse copy];
        cancelblock = [cancel copy];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:[self class] cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        
        for (NSString *buttonTitle in otherButtonTitles)
        {
            [alertView addButtonWithTitle:buttonTitle];
        }
        
        [alertView show];
    }
}

+ (void)alertWithStyle:(UIAlertControllerStyle)style
                 title:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
            controller:(UIViewController *)controller
             onDismiss:(void (^)(int buttonIndex, NSString *buttonTitle))dismisse
              onCancel:(void (^)(void))cancel
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:style];
    
    if (cancelButtonTitle && 0 != cancelButtonTitle.length)
    {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel)
            {
                cancel();
            }
        }];
        [alertController addAction:cancelAction];
    }
    
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (dismisse)
            {
                NSString *buttonTitle = obj;
                dismisse(((int)idx), buttonTitle);
            }
        }];
        [alertController addAction:okAction];
    }];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UIAlertViewDelegate

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        if (cancelblock)
        {
            cancelblock();
        }
    }
    else
    {
        if (dismissblock)
        {
            NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
            dismissblock(buttonIndex, title);
        }
    }
}

@end
