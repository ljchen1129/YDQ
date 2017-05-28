//
//  NSObject+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  图片对象类型（图片名称、图片url地址、图片image）
 */
typedef NS_ENUM(NSInteger, ImageType) {
    /**
     *  图片对象类型-图片名称
     */
    ImageTypeName = 1,
    /**
     *  图片对象类型-图片url地址
     */
    ImageTypeUrl = 2,
    /**
     *  图片对象类型-图片image
     */
    ImageTypeImage = 3
};

@interface NSObject (SYHelper)

/// 计算字符高度（根据字符，字体，及指定宽度）
- (CGFloat)heightWithText:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/// 单行文字宽度
- (CGFloat)widthWithText:(NSString *)string font:(UIFont *)font;

/// 结束编辑
- (void)endEditting;

/**
 *  判断图片类型（图片名称，或图片url地址，或图片image）
 *
 *  @return 图片类型
 */
- (ImageType)imageTypeWithImage;

@end
