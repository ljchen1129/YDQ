//
//  UIImage+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SYHelper)

#pragma mark - 图片处理

/// 图片拉升
- (void)resizableImage;

/// 改变图片大小
- (UIImage *)scaleImageWithSize:(float)size;

/// 生成圆角图片
- (UIImage *)GetRoundedRectImage:(UIImage *)image roundRadius:(CGFloat)radius;

/// 方形图片
- (UIImage *)GetSquareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/// UIImage转为灰度图 CGColorSpaceCreateDeviceGray会创建一个设备相关的灰度颜色空间的引用。
- (UIImage *)GetGrayImage:(UIImage *)sourceImage;

#pragma mark - 截图

/// 屏幕截图（指定视图范围）
+ (UIImage *)getScreenImageFromView:(UIView *)view;

/// 从图片中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImage:(UIImage *)image screenSize:(CGRect)rect;

/// 从视图中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImage:(UIView *)view inRect:(CGRect)frame;

#pragma mark - 纯色图片

/// 生成指定颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


#pragma mark - 图片保存

/// 保存图片到指定路径，是否成功回调
- (void)saveImageWithPath:(NSString *)path complete:(void (^)(BOOL isSuccess))complete;

/// 保存图片到手机相册，是否成功回调
- (void)saveImageToPhotosAlbum:(void (^)(BOOL isSuccess))complete;



#pragma mark - 获取相册图片

/// 获取n张相片（0时为全部），最新的或最早的
- (void)GetImagesFromAssetsLibraryWithNum:(NSInteger)count latest:(BOOL)latest start:(void(^)(void))start success:(void(^)(NSArray *images))success error:(void(^)(void))error;


#pragma mark - 图片转二进制流字符串

/**
 *  图片转二进制流字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流字符串
 */
- (NSString *)imageBytesStringWithImageCompressionQuality:(CGFloat)quality;

/**
 *  图片转二进制流
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流
 */
- (NSData *)imageDataWithImageCompressionQuality:(CGFloat)quality;

/**
 *  图片转二进制流base64字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流base64字符串
 */
- (NSString *)imageBase64StringWithImageCompressionQuality:(CGFloat)quality;

@end
