//
//  NSString+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSString+SYHelper.h"
#import "RegexKitLite.h"

@implementation NSString (SYHelper)

#pragma mark - 字符处理方法

/// 字符隐藏显示设置（使用诸如“*”符号代替，同时设置只显示前几位，及后几位）
- (NSString *)textHiddenWithSymbol:(NSString *)symbol showBegin:(NSInteger)begin showEnd:(NSInteger)end
{
    if (![NSString isNullNSString:symbol])
    {
        NSInteger countLength = self.length;
        NSInteger countBegin = begin;
        NSInteger countEnd = end;
        if ((countBegin + countEnd <= countLength) && (begin >= 0 && end >= 0))
        {
            NSInteger countHidden = countLength - countBegin - countEnd;
            
            NSMutableString *stringSymbol = [NSMutableString string];
            for (NSInteger i = 0; i < countHidden; i++)
            {
                [stringSymbol appendString:symbol];
            }
            
            NSRange rangeHidden = NSMakeRange(countBegin, countHidden);
            NSString *stringHidden = [self stringByReplacingCharactersInRange:rangeHidden withString:stringSymbol];
            
            return stringHidden;
        }
        
        return self;
    }
    
    return self;
}

/// 数字字符串保留小数点后任意位数
static NSString *const keyDecimalPoint = @".";
- (NSString *)textKeepDecimalPointWithNumber:(NSInteger)length
{
    NSRange rangePoint = [self rangeOfString:keyDecimalPoint];
    if (rangePoint.location != NSNotFound)
    {
        NSString *decimalString = [self substringFromIndex:rangePoint.location + rangePoint.length];
        NSInteger countDecimal = decimalString.length;
        NSInteger countKeep = length;
        countKeep = (countKeep >= countDecimal ? countDecimal : (countKeep > 0 ? countKeep : 0));
        
        NSString *resultString = [self substringToIndex:rangePoint.location + rangePoint.length + countKeep];
        
        // 不足位数时补0
        countKeep = length - countDecimal;
        NSMutableString *zeroString = [NSMutableString string];
        for (NSInteger i = 0; i < countKeep; i++)
        {
            [zeroString appendString:@"0"];
        }
        resultString = [NSString stringWithFormat:@"%@%@", resultString, zeroString];
        
        return resultString;
    }
    else
    {
        // 不足位数时补0
        NSMutableString *zeroString = [NSMutableString stringWithString:keyDecimalPoint];
        for (NSInteger i = 0; i < length; i++)
        {
            [zeroString appendString:@"0"];
        }
        NSString *resultString = [NSString stringWithFormat:@"%@%@", self, zeroString];
        
        return resultString;
    }
}

/// 金额字符串转换显示样式（每三位以空格，或,进行分割显示）
- (NSString *)textMoneySeparatorWithSymbol:(NSString *)symbol
{
    if (![NSString isNullNSString:symbol])
    {
        NSString *textTmp = self;
        
        // 整数位
        NSString *textMoney = textTmp;
        // 小数位
        NSString *textZero = @"";
        // 正负数位
        NSString *textMinus = @"";
        
        // 判断是否含有负数
        NSRange rangeMinus = [textTmp rangeOfString:@"-"];
        if (rangeMinus.location != NSNotFound)
        {
            textMinus = @"-";
            textTmp = [textTmp substringFromIndex:(rangeMinus.location + rangeMinus.length)];
        }
        
        // 判断是否含有正数
        NSRange rangePositive = [textTmp rangeOfString:@"+"];
        if (rangePositive.location != NSNotFound)
        {
            textMinus = @"+";
            textTmp = [textTmp substringFromIndex:(rangePositive.location + rangePositive.length)];
        }
        
        // 判断是否含有小数，小数位不纳入处理
        NSRange rangeZero = [textTmp rangeOfString:keyDecimalPoint];
        if (rangeZero.location != NSNotFound)
        {
            textMoney = [textTmp substringToIndex:rangeZero.location];
            textZero = [textTmp substringFromIndex:rangeZero.location];
        }
        
        // 3位以下才进行分割处理
        NSInteger countLength = textMoney.length;
        NSInteger countSpace = 3;
        if (countLength > countSpace)
        {
            NSInteger countSymbol = countLength / countSpace;
            if (countLength % countSpace == 0)
            {
                // 刚好整除时，减1（如：6、9、12...3n）
                countSymbol -= 1;
            }
            
            NSInteger indexSymbol = 0;
            NSMutableString *stringSymbol = [NSMutableString stringWithString:textMoney];
            for (NSInteger i = 0; i < countSymbol; i++)
            {
                countLength = stringSymbol.length;
                indexSymbol = countLength - countSpace * (1 + i) - i;
                
                [stringSymbol insertString:symbol atIndex:indexSymbol];
            }

            [stringSymbol appendString:textZero];
            [stringSymbol insertString:textMinus atIndex:0];
            
            return stringSymbol;
        }
        
        return self;
    }
    
    return self;

}

#pragma mark - 字符异常判断方法

/// 有效字符（非空，且非空格）
+ (BOOL)isValidNSString:(NSString *)string;
{
    BOOL isResult = [self isNullBlankNSString:string];
    return !isResult;
}

/// 字符非空判断（可以是空格字符串）
+ (BOOL)isNullNSString:(NSString *)string;
{
    if (string == Nil || [string isEqualToString:@""] || 0 == string.length || [string isEqual:[NSNull class]])
    {
        return YES;
    }
    
    return NO;
}

/// 字符非空判断（不能是空格字符串）
+ (BOOL)isNullBlankNSString:(NSString *)string;
{
    NSString *stringTmp = [string textFilterBlankSpace];
    BOOL isResult = [self isNullNSString:stringTmp];
    return isResult;
}

/// 过滤字符串中的空格符
- (NSString *)textFilterBlankSpace
{
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *resultString = [self stringByTrimmingCharactersInSet:characterSet];
    return resultString;
}

/// 字符中是否包含汉字
- (BOOL)textContantCN
{
    BOOL isResult = NO;
    
    NSInteger count = self.length;
    for (NSInteger i = 0; i < count; i++)
    {
        int charCN = [self characterAtIndex:i];
        if (charCN > 0x4e00 && charCN < 0x9fff)
        {
            isResult = YES;
            break;
        }
    }
    
    return isResult;
}

/// 字符串是否是纯中文字符
- (BOOL)isCNNSString
{
    BOOL isResult = YES;
    
    NSInteger count = self.length;
    for (NSInteger i = 0; i < count; i++)
    {
        int charCN = [self characterAtIndex:i];
        if (charCN > 0x4e00 && charCN < 0x9fff)
        {
            continue;
        }
        else
        {
            isResult = NO;
            break;
        }
    }
    
    return isResult;
}

/// 判断输入的字符长度 一个汉字算2个字符，是否区分中英文
- (NSUInteger)textLength:(BOOL)isCN
{
    NSUInteger asciiLength = 0;
    NSInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++)
    {
        unichar uc = [self characterAtIndex:i];
        asciiLength += (isascii(uc) ? 1 : (isCN ? 2 : 1));
    }
    return asciiLength;
}


#pragma mark - 正则判断

/// 正则判断
- (BOOL)isValidText:(NSString *)regex
{
    BOOL isResult = [self isMatchedByRegex:regex];
    return isResult;
}

/// 字符是否是固定电话
- (BOOL)isValidTextTel
{
    BOOL isResult = [self isValidText:@"^[^1]\\d{9,11}$"];
    return isResult;
}

/// 字符是否是手机号
- (BOOL)isValidTextMobile
{
    BOOL isResult = [self isValidText:@"^(13[0-9]|14[57]|15[0-9]|17[012356789]|18[0-9])\\d{8}$"];
    return isResult;
}

/// 字符是否是邮编
- (BOOL)isValidTextPostcode
{
    BOOL isResult = [self isValidText:@"[1-9]{1}(\\d+){5}"];
    return isResult;
}

/// 字符是否是email
- (BOOL)isValidTextEMail
{
    BOOL isResult = [self isValidText:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
    return isResult;
}

/// 字符是否是空格
- (BOOL)isValidTextBlankSpace
{
    BOOL isResult = [self isValidText:@"\\s"];
    return isResult;
}

/// 字符是否是有效帐户（数字与大小写字母组成，4~12位）
- (BOOL)isValidTextAccount
{
    BOOL isResult = [self isValidText:@"^[0-9a-zA-Z]{4,12}$"];
    return isResult;
}

// 字符是否是有效密码（字母数字组成，8-16位）
- (BOOL)isValidPassword
{
    BOOL isResult = [self isValidText:@"^[0-9a-zA-Z]{8,16}$"];
    return isResult;
}

/// 字符是否是有效的银行卡号（12~19位数字）
- (BOOL)isValidTextBankCardNumber
{
    BOOL isResult = [self isValidText:@"^[0-9]{12,19}$"];
    return isResult;
}

/// 字符是否指定金额字符（100位整数，2位小数）
- (BOOL)isValidTextMoney
{
    BOOL isResult = [self isValidText:@"^(([1-9]\\d{0,100})|0)(\\.\\d{1,2})?$"];
    return isResult;
}

/// 字符是否只包含 数字/大小写字母/_/@/.
- (BOOL)isValidRegisterAccount
{
    BOOL isResult = [self isValidText:@"[0-9a-zA-Z_.@]"];
    return isResult;
}

/// 字符是否是合法身份证账号（数字与字母组成）
- (BOOL)isValidTextIDCard
{
    BOOL isResult = [self isValidText:@"[0-9xX]"];
    return isResult;
}

/// 字符是否是有效的匹配身份证号码
- (BOOL)isValidTextIdentityCard
{
    // 判断位数
    NSInteger countCard = self.length;
    if (countCard == 15 || countCard == 18)
    {
        NSString *identityCard = self;
        long lSumQT = 0;
        
        // 加权因子
        int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
        
        // 校验码
        unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
        
        // 将15位身份证号转换成18位
        NSMutableString *mString = [NSMutableString stringWithString:self];
        if (countCard == 15)
        {
            [mString insertString:@"19" atIndex:6];
            long p = 0;
            const char *pid = [mString UTF8String];
            for (int i = 0; i <= 16; i++)
            {
                p += (pid[i] - 48) * R[i];
            }
            int o = p % 11;
            NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
            [mString insertString:string_content atIndex:[mString length]];
            identityCard = mString;
        }
        
        // 判断地区码
        NSString * sProvince = [identityCard substringToIndex:2];
        if (![self areaCode:sProvince])
        {
            return NO;
        }
        
        // 判断年月日是否有效
        // 年份
        int strYear = [[identityCard substringWithRange:NSMakeRange(6,4)] intValue];
        // 月份
        int strMonth = [[identityCard substringWithRange:NSMakeRange(10,2)] intValue];
        // 日
        int strDay = [[identityCard substringWithRange:NSMakeRange(12,2)] intValue];
        
        NSTimeZone *localZone = [NSTimeZone localTimeZone];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setTimeZone:localZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
        if (date == nil)
        {
            return NO;
        }
        const char *PaperId  = [identityCard UTF8String];
        
        // 检验长度
        if (18 != strlen(PaperId))
        {
            return -1;
        }
        
        // 校验数字
        for (int i = 0; i < 18; i++)
        {
            if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i))
            {
                return NO;
            }
        }
        
        // 验证最末的校验码
        for (int i = 0; i <= 16; i++)
        {
            lSumQT += (PaperId[i] - 48) * R[i];
        }
        if (sChecker[lSumQT % 11] != PaperId[17] )
        {
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil)
    {
        return NO;
    }
    
    return YES;
}

/// 正则判断
- (BOOL)isValidTextWithPredicate:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isResult = [predicate evaluateWithObject:self];
    return isResult;
}

#pragma mark - 表情输入限制

/// 包含表情字符
- (BOOL)isEmojiString
{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
             }
         }
         else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3)
             {
                 isEomji = YES;
             }
         }
         else
         {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b)
             {
                 isEomji = YES;
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 isEomji = YES;
             }
             else if (0x2934 <= hs && hs <= 0x2935)
             {
                 isEomji = YES;
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 isEomji = YES;
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a )
             {
                 isEomji = YES;
             }
         }
     }];
    
    return isEomji;
}

@end
