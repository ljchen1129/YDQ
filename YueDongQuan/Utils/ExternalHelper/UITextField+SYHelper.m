//
//  UITextField+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UITextField+SYHelper.h"
#import <objc/runtime.h>

static NSString *const keyMaxLength = @"limitMaxLength";

@implementation UITextField (SYHelper)

#pragma mark - 输入限制

/// 设置TextField空白间隙，左侧或右侧（默认10个间距）
- (void)viewModeType:(TextFieldViewModeType)type
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, CGRectGetHeight(self.bounds))];
    view.backgroundColor = [UIColor clearColor];
    if (TextFieldViewModeTypeLeft == type)
    {
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    else if (TextFieldViewModeTypeRight == type)
    {
        self.rightView = view;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

/// 手机号输入限制
- (BOOL)limitMoblieShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self isFirstResponder])
    {
        NSCharacterSet *firstSet = [NSCharacterSet characterSetWithCharactersInString:@"1"];
        NSCharacterSet *middleSet = [NSCharacterSet characterSetWithCharactersInString:@"345678"];
        NSCharacterSet *lastSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"text(length = %ld) %@", tempStr.length, tempStr);
        
        // 手机号输入限制
        if (1 < tempStr.length)
        {
            // 光标移动到首位时，输入只能为1
            NSString *firstStr = [tempStr substringToIndex:1];
            NSRange firstRange = [firstStr rangeOfCharacterFromSet:firstSet];
            if (firstRange.location == NSNotFound)
            {
                return NO;
            }
            
            // 第二位输入为3-9
            NSString *middleStr = [tempStr substringWithRange:NSMakeRange(1, 1)];
            if (middleStr && 0 != middleStr.length)
            {
                NSRange middleRange = [middleStr rangeOfCharacterFromSet:middleSet];
                if (middleRange.location == NSNotFound)
                {
                    return NO;
                }
            }
            
            // 第3~11位输入为0~9
            NSString *lastStr = [tempStr substringFromIndex:2];
            if (lastStr && 0 != lastStr.length)
            {
                NSRange lastRange = [lastStr rangeOfCharacterFromSet:lastSet];
                if (lastRange.location == NSNotFound)
                {
                    return NO;
                }
            }
        }
        else if (1 == tempStr.length)
        {
            // 首位只能输入1
            NSRange firstRange = [tempStr rangeOfCharacterFromSet:firstSet];
            if (firstRange.location == NSNotFound)
            {
                return NO;
            }
        }
        
        // 手机号最多11位
        if (11 < tempStr.length)
        {
            self.text = [tempStr substringToIndex:11];
            return NO;
        }
    }
    
    return YES;
}


/// 数字输入限制（integerLength整数位数0时无限制；greater整数首位是否大于0；decimal是否带小数，decimalLength小数位数）
- (BOOL)limitNumberShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string integer:(NSInteger)integerLength greaterThanZero:(BOOL)greater decimalPoint:(BOOL)decimal decimalDigits:(NSInteger)decimalLength
{
    if ([self isFirstResponder])
    {
        NSCharacterSet *withoutZeroNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
        NSCharacterSet *withZeroNumberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
        NSString *decimalString = @".";
        NSString *zeroString = @"0";
        
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
        DLog(@"text(integerLength=%ld length = %ld) %@", (long)integerLength, tempStr.length, tempStr);
        
        if (1 < tempStr.length)
        {
            NSString *firstString = [tempStr substringWithRange:NSMakeRange(0, 1)];
            if ([zeroString isEqualToString:firstString])
            {
                // 第一个是0时，且第二个非小数点时，自动去掉第一个0
                NSString *secondString = [tempStr substringWithRange:NSMakeRange(1, 1)];
                if ([decimalString isEqualToString:secondString])
                {
                    // 带小数
                    if (decimal)
                    {
                        NSRange decimalRange = [tempStr rangeOfString:decimalString];
                        if (decimalRange.location != NSNotFound)
                        {
                            // 小数点后decimalLength位
                            NSInteger decimal = (decimalRange.location + decimalRange.length + decimalLength + 1);
                            if (decimal <= tempStr.length)
                            {
                                return NO;
                            }
                        }
                    }
                }
                else
                {
                    self.text = [tempStr substringFromIndex:1];
                    return NO;
                }
            }
            else
            {
                // 第一个非0时
                for (int i = 0; i < tempStr.length; i++)
                {
                    NSString *subString = [tempStr substringWithRange:NSMakeRange(i, 1)];
                    
                    // 只能输入数字和小数点
                    NSRange numberRange = [subString rangeOfCharacterFromSet:(decimal ? limitSet : withZeroNumberSet)];
                    if (numberRange.location == NSNotFound)
                    {
                        return NO;
                        break;
                    }
                    
                    if (decimal)
                    {
                        // 只能有一个小数点
                        NSArray *array = [tempStr componentsSeparatedByString:decimalString];
                        if (3 <= array.count)
                        {
                            return NO;
                            break;
                        }
                    }
                }
                
                // 带小数
                if (decimal)
                {
                    NSRange decimalRange = [tempStr rangeOfString:decimalString];
                    if (decimalRange.location != NSNotFound)
                    {
                        // 小数点后decimalLength位
                        NSInteger decimal = (decimalRange.location + decimalRange.length + decimalLength + 1);
                        if (decimal <= tempStr.length)
                        {
                            return NO;
                        }
                    }
                }
                
                // 整数长度，0时整数输入无限制
                if (integerLength != 0)
                {
                    NSRange decimalRange = [tempStr rangeOfString:decimalString];
                    NSString *subString = tempStr;
                    if (decimalRange.location != NSNotFound)
                    {
                        subString = [tempStr substringToIndex:decimalRange.location];
                    }
                    
                    NSInteger integer = (integerLength + 1);
                    if (integer <= subString.length)
                    {
                        return NO;
                    }
                }
            }
        }
        else if (1 == tempStr.length)
        {
            // 首个输入限制，只能输入1~9，或只有输入0~9
            NSRange numberRange = [tempStr rangeOfCharacterFromSet:(greater ? withoutZeroNumberSet : withZeroNumberSet)];
            if (decimal && !greater)
            {
                // 带小数点时，且首个输入非大于0时，允许首个输入小数点，并默认格式为"0.xxx"
                numberRange = [tempStr rangeOfCharacterFromSet:limitSet];
                if ([decimalString isEqualToString:tempStr])
                {
                    self.text = [NSString stringWithFormat:@"%@%@", zeroString, decimalString];
                    return NO;
                }
            }
            
            if (numberRange.location == NSNotFound)
            {
                return NO;
            }
        }
    }
    return YES;
}

/// 第N位限制不能输入指定字符（limits限制不能输入的字符；index限制的第N位）
- (BOOL)limitCharacterShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string limitCharacters:(NSString *)limits limitIndex:(NSInteger)index
{
    if ([self isFirstResponder])
    {
        NSCharacterSet *limitSet = [NSCharacterSet characterSetWithCharactersInString:limits];
        
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
        DLog(@"text(index=%ld length = %ld) %@", (long)index, tempStr.length, tempStr);
        
        NSInteger beginIndex = index - 1;
        NSInteger startIndex = index;
        
        if (1 < tempStr.length)
        {
            NSString *firstString = [tempStr substringWithRange:NSMakeRange(beginIndex, 1)];
            NSRange range = [firstString rangeOfCharacterFromSet:limitSet];
            if (range.location != NSNotFound)
            {
                self.text = [tempStr substringFromIndex:startIndex];
                return NO;
            }
        }
        else if (1 == tempStr.length)
        {
            if (beginIndex == 0)
            {
                NSString *firstString = tempStr;
                NSRange range = [firstString rangeOfCharacterFromSet:limitSet];
                if (range.location != NSNotFound)
                {
                    self.text = [tempStr substringFromIndex:1];
                    return NO;
                }
            }
        }
    }
    return YES;
}

/// 限制输入长度
- (BOOL)limitLength:(int)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 输入限制
    if ([self isFirstResponder] && self.text.length != 0)
    {
        NSString *tempStr = [self.text stringByReplacingCharactersInRange:range withString:string];
        DLog(@"text(max=%d length = %ld) %@", maxLength, tempStr.length, tempStr);
        
        // 限制最多输入位数
        if (tempStr.length > maxLength)
        {
            self.text = [tempStr substringToIndex:maxLength];
            return NO;
        }
    }
    
    return YES;
}

/// 限制textField输入的文字，能输入或不能输入
- (BOOL)limitTextFieldText:(NSString *)string limitStr:(NSString *)limitStr edit:(BOOL)canEdit
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:limitStr] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL result = [string isEqualToString:filtered];
    result = (canEdit ? result : !result);
    return result;
}

/// 限制输入的字符（string当前正在输入的字符；limitStr限制不能输入的字符串。"- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string"中使用）
- (BOOL)limitTextField:(NSString *)string limitStr:(NSString *)limitStr
{
    if (![string isEqualToString:@""])
    {
        NSRange range = [limitStr rangeOfString:string];
        if (range.location == NSNotFound)
        {
            return  NO;
        }
    }
    
    NSString *text = self.text;
    NSInteger length = text.length;
    for (int i = 0; i < length; i++)
    {
        NSString *subText = [text substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [limitStr rangeOfString:subText];
        if (range.location == NSNotFound)
        {
            break;
            return  NO;
        }
    }
    return YES;
}

#pragma mark - 输入限制长度（通知方法中使用）

/// 限制UITextField输入的长度（不区分中英文字符）
- (void)limitTextFieldLength:(NSUInteger)maxLength
{
    NSString *text = self.text;
    NSInteger length = [self textLength:text CNText:NO];
    if (length > maxLength)
    {
        self.text = [text substringToIndex:maxLength];
    }
}

/// 限制UITextField输入的长度（区分中英文字符）
- (void)limitTextFieldCNLength:(NSUInteger)maxLength
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFiledEditChanged:(NSNotification *)notification
{
    if ([self isFirstResponder])
    {
        NSInteger maxLength = self.limitMaxLength.integerValue;
        [self limitTextFieldLength:maxLength];
    }
}


@end
