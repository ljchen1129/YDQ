//
//  UIAlertController+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/21.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIAlertController+SYHelper.h"

#define isIOS8System ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

typedef void (^DismissBlock)(NSInteger buttonIndex, NSString *buttonTitle);
typedef void (^CancelBlock)(void);
static DismissBlock dismissblock;
static CancelBlock cancelblock;

@implementation UIAlertController (SYHelper)

/// 封装Block（type-alert/actionSheet、title标题、message信息对UIActionSheet无效、cancelButtonTitle/otherButtonTitles按钮、dismisse/cancel响应方法、showInView针对UIActionSheet有效）
+ (void)alertWithViewType:(AlertViewType)type
                    title:(NSString *)title
                  message:(NSString *)message
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSArray *)otherButtonTitles
               controller:(UIViewController *)controller
               showInView:(UIView *)view
                onDismiss:(void (^)(int buttonIndex, NSString *buttonTitle))dismisse
                 onCancel:(void (^)(void))cancel
{
    if (AlertViewTypeAlert == type)
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
    else if (AlertViewTypeActionSheet == type)
    {
        if (isIOS8System && controller)
        {
            [[self class] alertWithStyle:UIAlertControllerStyleActionSheet title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles controller:controller onDismiss:dismisse onCancel:cancel];
        }
        else
        {
            dismissblock = [dismisse copy];
            cancelblock = [cancel copy];
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:[self class] cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil];
            
            for (NSString *buttonTitle in otherButtonTitles)
            {
                [actionSheet addButtonWithTitle:buttonTitle];
            }
            
            [actionSheet showInView:view];
        }
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
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel)
        {
            cancel();
        }
    }];
    [alertController addAction:cancelAction];
    
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

#pragma mark - UIAlertViewDelegate

+ (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex])
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
            NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
            dismissblock(buttonIndex, title);
        }
    }
}

@end
