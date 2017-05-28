//
//  UITextView+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/2/15.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITextView+SYHelper.h"
#import <objc/runtime.h>

static NSString *const keyMaxLength = @"limitMaxLength";

@implementation UITextView (SYHelper)

#pragma mark - 输入限制长度（通知方法中使用）

/// 限制UITextView输入的长度（不区分中英文字符）
- (void)limitTextViewLength:(NSUInteger)maxLength
{
    NSString *text = self.text;
    NSInteger length = [self textLength:text CNText:NO];
    if (length > maxLength)
    {
        self.text = [text substringToIndex:maxLength];
    }
}

/// 限制UITextView输入的长度（区分中英文字符）
- (void)limitTextViewCNLength:(NSUInteger)maxLength
{
    NSString *text = self.text;
    NSInteger length = [self textLength:text CNText:YES];
    if (length > maxLength)
    {
        self.text = [text substringToIndex:maxLength];
    }
}



/// 判断输入的字符长度 一个汉字算2个字符，是否区分中英文
- (NSUInteger)textLength:(NSString *)text CNText:(BOOL)isCN
{
    NSUInteger asciiLength = 0;
    NSInteger length = text.length;
    for (NSUInteger i = 0; i < length; i++)
    {
        unichar uc = [text characterAtIndex:i];
        asciiLength += (isascii(uc) ? 1 : (isCN ? 2 : 1));
    }
    return asciiLength;
}


#pragma mark - 属性

- (void)setLimitMaxLength:(NSNumber *)limitMaxLength
{
    if (0 < limitMaxLength.integerValue)
    {
        objc_setAssociatedObject(self, &keyMaxLength, limitMaxLength, OBJC_ASSOCIATION_RETAIN);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

- (NSNumber *)limitMaxLength
{
    NSNumber *limitMaxLength = objc_getAssociatedObject(self, &keyMaxLength);
    return limitMaxLength;
}


#pragma mark - 通知方法

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textViewEditChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        NSInteger maxLength = self.limitMaxLength.integerValue;
        [self limitTextViewLength:maxLength];
    }
}

@end
