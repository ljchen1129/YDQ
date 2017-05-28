//
//  Common_limit.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用限制

#ifndef zhangshaoyu_Common_limit_h
#define zhangshaoyu_Common_limit_h

/********************** limit ****************************/

#pragma mark - 输入限制

/// 提示符时间长度
static NSTimeInterval const kHUDTime = 2.5;

/// 动画时间长度
static NSTimeInterval const kAnimationsTime = 0.3;

/// 分割线高度
static CGFloat const kSeparatorlineHeight = 0.5;

/// 注册模块
static NSInteger const kMax_AccountHX           = 32;  // 惠信用户名:4-32 字母数字下划线构成 可以是邮箱 张绍裕 20140904
static NSInteger const kMax_Account             = 20;  // 用户名:4-20 字母数字下划线构成 可以是邮箱
static NSInteger const kMax_Password            = 20;  // 密码:6-20位  字母数字构成
static NSInteger const kMin_Password            = 6;   // 密码最少6位
static NSInteger const kMax_PayPassword         = 16;  // 交易密码: 6-16位 字母和数字构成
static NSInteger const kMax_NickName            = 10;  // 昵称:最多20位字符
static NSInteger const kMax_MessageValidateCode = 6;   // 验证码:6位
static NSInteger const kMax_Signature           = 100; // 个性签名
static NSInteger const kMax_Address             = 100; // 地址
static NSInteger const kMax_Phone               = 11;  // 手机号
static NSInteger const kMax_Tel                 = 18;  // 电话号

static NSInteger const kMax_MerchantsName       = 20;  // 商家姓名
static NSInteger const kMax_shopName            = 40;  // 商家店铺名称
static NSInteger const kMax_shopIntroduce       = 200; // 商家店铺介绍
static NSInteger const kMax_projectName         = 40;  // 项目名称

static NSInteger const kMax_IDCardNum           = 18; // 身份证号
static NSInteger const kMax_RealName            = 20; // 真实姓名
static NSInteger const kMax_Money               = 12; // 充值金额位数限制
static NSInteger const kMin_BankCardNumber      = 12; // 12位号码
static NSInteger const kMax_BankCardNumber      = 19; // 19位号码



/// 字符输入限制
static NSString *const NUMBERS     = @"0123456789";
static NSString *const xX          = @"xX";
static NSString *const kAlphaNum   = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";



static NSString *const Special_Character = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'";

static NSString *const SpecialCharacterAndNumber = @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789";

static NSString *const AllCharacterAndNumber =@"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";


/// 验证码，或其他数字输入（数字）
static NSString *const kRegexNumber = @"[0-9]";
/// 验证码，或其他数字输入（数字/大小写字母）
static NSString *const kRegexNumberLetter = @"[A-Za-z0-9]";
/// 验证码，或其他数字输入（大小写字母）
static NSString *const kRegexLetter = @"[A-Za-z]";
/// 验证码，或其他数字输入（大写字母）
static NSString *const kRegexUppercaseLetter = @"[A-Z]";
/// 验证码，或其他数字输入（小定字母）
static NSString *const kRegexLowercaseLetter = @"[a-z]";
/// 验证码，或其他数字输入（中文）
static NSString *const kRegexCN =@"[0x4e00-0x9fff]";
/// 验证码，或其他数字输入（数字/大小写字母/中文）
static NSString *const kRegexNumberLetterCN = @"[A-Za-z0-9\u4e00-\u9fa5]"; // \u4e00-\u9fa5 \0x4e00-\0x9fff

//@"^[0-9a-zA-Z]{4,12}$"


/********************** limit ****************************/

#endif
