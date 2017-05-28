//
//  UIAlertController+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/21.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 弹窗视图种类（alertView，或actionSheet）
typedef NS_ENUM(NSInteger, AlertViewType)
{
    /// 弹窗视图种类 alertView
    AlertViewTypeAlert = 0,
    
    /// 弹窗视图种类 actionSheet
    AlertViewTypeActionSheet = 1
};

@interface UIAlertController (SYHelper) <UIActionSheetDelegate>

/// 封装Block（type-alert/actionSheet、title标题、message信息对UIActionSheet无效、cancelButtonTitle/otherButtonTitles按钮、dismisse/cancel响应方法、showInView针对UIActionSheet有效）
+ (void)alertWithViewType:(AlertViewType)type
                    title:(NSString *)title
                  message:(NSString *)message
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSArray *)otherButtonTitles
               controller:(UIViewController *)controller
               showInView:(UIView *)view
                onDismiss:(void (^)(int buttonIndex, NSString *buttonTitle))dismisse
                 onCancel:(void (^)(void))cancel;

@end
