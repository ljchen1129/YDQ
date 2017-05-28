//
//  UIView+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SYHelper)

/// 设置UI视图的边框属性
- (void)layerWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width;

#pragma mark - 解摸手势

/// 单击，或双击响应
- (void)tapRecognizer:(NSInteger)tapNumber action:(void (^)(UITapGestureRecognizer *recognizer))action;

/// 长按手势（长按时间默认0.5）
- (void)longPressRecognizer:(CFTimeInterval)time action:(void (^)(UILongPressGestureRecognizer *recognizer))action;

/// 拖动手势
- (void)panRecognizer:(void (^)(UIPanGestureRecognizer *recognizer))action;

/// 拿捏缩放手势
- (void)pinchRecognizer:(void (^)(UIPinchGestureRecognizer *recognizer))action;

/// 滑动手势
- (void)swipeRecognizer:(UISwipeGestureRecognizerDirection)direction action:(void (^)(UISwipeGestureRecognizer *recognizer))action;

/// 旋转手势
- (void)rotationRecognizer:(void (^)(UIRotationGestureRecognizer *recognizer))action;

@end
