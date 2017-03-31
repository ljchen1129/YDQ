//
//  UIImage+CLJExtension.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CLJExtension)

/// 生成指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
