//
//  UIImage+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIImage+SYHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^SaveToPhotosAlbumComplete)(BOOL isSuccess);
static SaveToPhotosAlbumComplete saveToPhotosAlbumComplete;


#pragma mark - 获取相册图片
static ALAssetsLibrary *assetsLibrary;
static NSMutableArray *imageResults;
typedef void (^startBlock)(void);
static startBlock assetsLibraryStartBlock;
typedef void (^successBlock)(NSArray *imageSuccess);
static successBlock assetsLibrarySuccessBlock;
typedef void (^errorBlock)(void);
static errorBlock assetsLibraryErrorBlock;


@implementation UIImage (SYHelper)

#pragma mark - 图片处理

/// 图片拉升
- (void)resizableImage
{
    [self resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0) resizingMode:UIImageResizingModeStretch];
}

/// 改变图片大小
- (UIImage *)scaleImageWithSize:(float)size
{
    CGSize temSize = CGSizeZero;
    if (MIN(self.size.width, self.size.height) <= size)
    {
        temSize = self.size;
    }
    else if (self.size.width - self.size.height > 0)
    {
        temSize = CGSizeMake(self.size.width * size / self.size.height, size);
    }
    else
    {
        temSize = CGSizeMake(size, self.size.height * size / self.size.width);
    }
    
    UIGraphicsBeginImageContext(temSize);
    [self drawInRect:CGRectMake(0, 0, temSize.width, temSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

// 将图片裁剪成圆角的，并没有改变图片的质量
static void AddRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

/// 生成圆角图片
- (UIImage *)GetRoundedRectImage:(UIImage *)image roundRadius:(CGFloat)radius
{
    if (!radius)
    {
        radius = 8;
    }
    // the size of CGContextRef
    int w = image.size.width;
    int h = image.size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    AddRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

/// 方形图片
- (UIImage *)GetSquareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    double ratio;
    double delta;
    CGPoint offset;
    
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    if (image.size.width > image.size.height)
    {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta / 2, 0);
    }
    else
    {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta / 2);
    }
    
    CGRect clipRect = CGRectMake(-offset.x, -offset.y, (ratio * image.size.width) + delta, (ratio * image.size.height) + delta);
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    }
    else
    {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/// UIImage转为灰度图 CGColorSpaceCreateDeviceGray会创建一个设备相关的灰度颜色空间的引用。
- (UIImage *)GetGrayImage:(UIImage *)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL)
    {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}


#pragma mark - 截图

/// 屏幕截图（指定视图范围）
+ (UIImage *)getScreenImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

/// 从图片中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImage:(UIImage *)image screenSize:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}

/// 从视图中按指定的位置大小截取图片的一部分
+ (UIImage *)screenImage:(UIView *)view inRect:(CGRect)frame
{
    CGRect rect = frame;
    
    // 开始取图，参数：截图图片大小
    UIGraphicsBeginImageContext(rect.size);
    // 截图层放入上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束截图
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 纯色图片

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


#pragma mark - 图片保存

/// 保存图片到指定路径，是否成功回调
- (void)saveImageWithPath:(NSString *)path complete:(void (^)(BOOL isSuccess))complete
{
    /*
     NSData *imageData = UIImageJPEGRepresentation(tempImage, 1.0);
     NSString *fullPathToFile  = [self cachesFolderPathWithName:imageName];
     [imageData writeToFile:path atomically:NO];
     return fullPathToFile;
     */
    
    NSData *imageData = UIImageJPEGRepresentation(self, 0.5);
    BOOL isResult = [imageData writeToFile:path atomically:NO];
    if (complete)
    {
        complete(isResult);
    }
}

/// 保存图片到手机相册，是否成功回调
- (void)saveImageToPhotosAlbum:(void (^)(BOOL isSuccess))complete
{
    saveToPhotosAlbumComplete = complete;
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    BOOL isResult = (error == nil ? YES : NO);
    if (saveToPhotosAlbumComplete)
    {
        saveToPhotosAlbumComplete(isResult);
    }
}


#pragma mark - 获取相册图片

/// 获取n张相片（0时为全部），最新的或最早的
- (void)GetImagesFromAssetsLibraryWithNum:(NSInteger)count latest:(BOOL)latest start:(void(^)(void))start success:(void(^)(NSArray *images))success error:(void(^)(void))error
{
    [self removeImage];
    
    NSInteger imageCount = count;
    BOOL islatest = latest;
    
    assetsLibraryStartBlock = [start copy];
    assetsLibrarySuccessBlock = [success copy];
    assetsLibraryErrorBlock = [error copy];
    
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    imageResults = [[NSMutableArray alloc] init];
    
    __weak UIImage *weakSelf = self;
    
    __block NSString *assetPropertyType = ALAssetTypePhoto;
    __block NSMutableArray *assets = [[NSMutableArray alloc] init];
    
    if (assetsLibraryStartBlock)
    {
        assetsLibraryStartBlock();
    }
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
        {
            if (!group)
            {
                return;
            }
            *stop = YES;
            
            __block int num = 0;
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
             {
                 if (!result)
                 {
                     return;
                 }
                 
                 __block ALAsset *assetResult = result;
                 num++;
                 NSInteger numberOf = [group numberOfAssets];
                 
                 NSString *al_assetPropertyType = [assetResult valueForProperty:ALAssetPropertyType];
                 if ([al_assetPropertyType isEqualToString:assetPropertyType])
                 {
                     [assets addObject:assetResult];
                 }
                 
                 if (num == numberOf)
                 {
                     if (0 == imageCount)
                     {
                         [weakSelf GetImageAll:assets];
                     }
                     else
                     {
                         [weakSelf GetImagelastest:islatest num:imageCount images:assets];
                     }
                 }
             }];
        };
        
        // Group Enumerator Failure Block
        void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"error failure");
                
                if (assetsLibraryErrorBlock)
                {
                    assetsLibraryErrorBlock();
                }
            });
        };
        
        // Enumerate Albums
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                     usingBlock:assetGroupEnumerator
                                   failureBlock:assetGroupEnumberatorFailure];
    });
}

// 清空原有图片
- (void)removeImage
{
    if (imageResults && 0 != imageResults.count)
    {
        [imageResults removeAllObjects];
    }
}

// 获取所有相片
- (void)GetImageAll:(NSArray *)array
{
    for (ALAsset *assetResult in array)
    {
        // CGImageRef imageRef = [assetResult thumbnail]; // 缩略图
        CGImageRef imageRef = [[assetResult defaultRepresentation] fullScreenImage]; // 原图
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        if (image)
        {
            // 获取到第一张图片
            [imageResults addObject:image];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (assetsLibrarySuccessBlock)
        {
            assetsLibrarySuccessBlock(imageResults);
        }
    });
}

// 获取最新的，或最早的
- (void)GetImagelastest:(BOOL)latest num:(NSInteger)count images:(NSArray *)array
{
    if (!array || 0 == array.count)
    {
        return;
    }

    NSMutableArray *images = [[NSMutableArray alloc] initWithArray:array];
    NSInteger realCount = images.count; // 实际图片数量
    NSInteger limitCount = (realCount < count ? realCount : count); // 实际限制图片数量
    
    if (latest)
    {
        for (int i = 0; i < limitCount; i++)
        {
            ALAsset *assetResult = [images lastObject];
            // CGImageRef imageRef = [assetResult thumbnail]; // 缩略图
            CGImageRef imageRef = [[assetResult defaultRepresentation] fullScreenImage]; // 原图
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            if (image)
            {
                // 获取到第一张图片
                [imageResults addObject:image];
            }
            [images removeLastObject];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (assetsLibrarySuccessBlock)
            {
                assetsLibrarySuccessBlock(imageResults);
            }
        });
    }
    else
    {
        for (int i = 0; i < limitCount; i++)
        {
            ALAsset *assetResult = [images objectAtIndex:i];
            // CGImageRef imageRef = [assetResult thumbnail]; // 缩略图
            CGImageRef imageRef = [[assetResult defaultRepresentation] fullScreenImage]; // 原图
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            if (image)
            {
                // 获取到第一张图片
                [imageResults addObject:image];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (assetsLibrarySuccessBlock)
            {
                assetsLibrarySuccessBlock(imageResults);
            }
        });
    }
}

#pragma mark - 图片转二进制流字符串

/**
 *  图片转二进制流字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流字符串
 */
- (NSString *)imageBytesStringWithImageCompressionQuality:(CGFloat)quality
{
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
    NSStringEncoding imageEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSString *imageBytesStr = [[NSString alloc] initWithData:imageData encoding:imageEncoding];
    
    return imageBytesStr;
}

/**
 *  图片转二进制流
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流
 */
- (NSData *)imageDataWithImageCompressionQuality:(CGFloat)quality
{
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
  
    return imageData;
}

/**
 *  图片转二进制流base64字符串
 *
 *  @param quality 压缩精度（0.0 ~ 1.0）
 *
 *  @return 返回二进制流base64字符串
 */
- (NSString *)imageBase64StringWithImageCompressionQuality:(CGFloat)quality
{
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
    NSString *imageBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return imageBase64;
}

@end
