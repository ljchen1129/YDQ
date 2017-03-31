//
//  UIImage+CLJExtension.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "UIImage+CLJExtension.h"

@implementation UIImage (CLJExtension)

/// 生成指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGContextRef context = _newBitmapContext(size);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    
    CGContextRelease(context);
    CGImageRelease(imgRef);
    
    return img;
}

static CGContextRef _newBitmapContext(CGSize size)
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    size_t imgWith = (size_t)(size.width + 0.5);
    size_t imgHeight = (size_t)(size.height + 0.5);
    size_t bytesPerRow = imgWith * 4;
    
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imgWith,
                                                 imgHeight,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpaceRef);
    return context;
}

@end
