//
//  UITextView+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/2/15.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SYHelper)

#pragma mark - 输入限制长度（在通知方法中使用）

/// 限制UITextView输入的长度（不区分中英文字符）
- (void)limitTextViewLength:(NSUInteger)maxLength;

/// 限制UITextView输入的长度（区分中英文字符）
- (void)limitTextViewCNLength:(NSUInteger)maxLength;

#pragma mark - 属性

/// 字符输入字数限制
@property (nonatomic, strong) NSNumber *limitMaxLength;

@end

/*
 使用说明
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
 - (void)textViewEditChanged:(NSNotification *)notification
 {
     if ([self.textField isFirstResponder])
     {
         [self.textField limitTextFieldLength:10];
     }
 }
 
 */