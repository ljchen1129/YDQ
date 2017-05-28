//
//  NSString+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SYHelper)

#pragma mark - 字符处理方法

/// 字符隐藏显示设置（使用诸如“*”符号代替，同时设置只显示前几位，及后几位）
- (NSString *)textHiddenWithSymbol:(NSString *)symbol showBegin:(NSInteger)begin showEnd:(NSInteger)end;

/// 数字字符串保留小数点后任意位数
- (NSString *)textKeepDecimalPointWithNumber:(NSInteger)length;

/// 金额字符串转换显示样式（每三位以空格，或,进行分割显示）
- (NSString *)textMoneySeparatorWithSymbol:(NSString *)symbol;

#pragma mark - 字符异常判断方法

/// 有效字符（非空，且非空格）
+ (BOOL)isValidNSString:(NSString *)string;

/// 字符非空判断（可以是空格字符串）
+ (BOOL)isNullNSString:(NSString *)string;

/// 字符非空判断（不能是空格字符串）
+ (BOOL)isNullBlankNSString:(NSString *)string;

/// 过滤字符串中的空格符
- (NSString *)textFilterBlankSpace;

/// 字符中是否包含汉字
- (BOOL)textContantCN;

/// 字符串是否是纯中文字符
- (BOOL)isCNNSString;

/// 判断输入的字符长度 一个汉字算2个字符，是否区分中英文
- (NSUInteger)textLength:(BOOL)isCN;

#pragma mark - 正则判断

/// 正则判断
- (BOOL)isValidText:(NSString *)regex;

/// 字符是否是固定电话
- (BOOL)isValidTextTel;

/// 字符是否是手机号
- (BOOL)isValidTextMobile;

/// 字符是否是邮编
- (BOOL)isValidTextPostcode;

/// 字符是否是email
- (BOOL)isValidTextEMail;

/// 字符是否是空格
- (BOOL)isValidTextBlankSpace;

/// 字符是否是有效帐户（数字与大小写字母组成，4~12位）
- (BOOL)isValidTextAccount;

// 字符是否是有效密码（字母数字组成，8-16位）
- (BOOL)isValidPassword;

/// 字符是否是有效的银行卡号（12~19位数字）
- (BOOL)isValidTextBankCardNumber;

/// 字符是否指定金额字符（100位整数，2位小数）
- (BOOL)isValidTextMoney;

/// 字符是否只包含 数字/大小写字母/_/@/.
- (BOOL)isValidRegisterAccount;

/// 字符是否是合法身份证账号（数字与字母组成）
- (BOOL)isValidTextIDCard;

/// 字符是否是有效的匹配身份证号码
- (BOOL)isValidTextIdentityCard;


/// 正则判断
- (BOOL)isValidTextWithPredicate:(NSString *)regex;

#pragma mark - 表情输入限制

/// 包含表情字符
- (BOOL)isEmojiString;

@end
