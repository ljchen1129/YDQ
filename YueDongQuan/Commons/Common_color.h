//
//  Common_color.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用颜色

#ifndef zhangshaoyu_Common_color_h
#define zhangshaoyu_Common_color_h

/********************** Color ****************************/

#pragma mark - 颜色

/// 设置颜色
#define UIColorRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define UIColorRGB_Alpha(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

/// 设置随机色
#define UIRandomColor UIColorRGB(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

/// hex 传入@"#ffffff"或者@"0Xffffff"格式字符串
#define UIColorStringHex(hex)     [DataHelper colorWithHexString:hex]

/// 导航栏背景颜色
#define kColorNavBgroundWhite UIColorHex(0xfe6364)
#define kColorNavBgroundRed UIColorHex(0xE94415)

// 主题背景色
#define kColorBackground UIColorHex(0xedeeef)

/// 透明色
#define kColorClear [UIColor clearColor]

/// 白色-如导航栏字体颜色
#define kColorWhite UIColorHex(0xffffff)

/// 淡灰色-如普通界面的背景颜色
#define kColorLightgrayBackground UIColorHex(0xf5f5f5)

/// 灰色—如内容字体颜色
#define kColorLightgrayContent UIColorHex(0x969696)

/// 灰色-如输入框占位符字体颜色
#define kColorLightgrayPlaceholder UIColorHex(0xb1b1b1)

/// 深灰色
#define kColorDarkgray UIColorHex(0x666666)

/// 黑色-如输入框输入字体颜色或标题颜色
#define kColorBlack UIColorHex(0x323232)

/// 淡黑色
#define kColorLightBlack UIColorHex(0x646464)

/// 黑色-纯黑
#define kColorDeepBlack UIColorHex(0x000000)

/// 灰色—如列表cell分割线颜色
#define kColorSeparatorline UIColorHex(0xd6d7dc)

/// 灰色-边框线颜色
#define kColorBorderline UIColorHex(0xd6d7dc)

/// 绿色-如导航栏背景颜色
#define kColorGreenNavBground UIColorHex(0x38ad7a)

/// 绿色
#define kColorGreen UIColorHex(0x349c6f)

/// 深绿色
#define kColorDarkGreen UIColorHex(0x188d5a)

/// 橙色
#define kColorOrange UIColorHex(0xfe933d)

/// 深橙色
#define kColorDarkOrange UIColorHex(0xe48437)

/// 淡紫色
#define kColorLightPurple UIColorHex(0x909af8)

/// 红色
#define kColorRed UIColorHex(0xe95951)

/// 通用的红色文字颜色
#define kColorFontRed UIColorHex(0xe12228)

/// 蓝色
#define kColorBlue UIColorHex(0x0076ff)

/// 高雅黑
#define kColorElegantBlack UIColorRGB(29, 31, 38)

/********************** Color ****************************/

#endif
