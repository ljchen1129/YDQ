//
//  UIAlertView+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/22.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (SYHelper) <UIAlertViewDelegate>

/// 封装Block（title标题、message信息、cancelButtonTitle/otherButtonTitles按钮、dismisse/cancel响应方法）
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
            controller:(UIViewController *)controller
             onDismiss:(void (^)(int buttonIndex, NSString *buttonTitle))dismisse
              onCancel:(void (^)(void))cancel;

@end
