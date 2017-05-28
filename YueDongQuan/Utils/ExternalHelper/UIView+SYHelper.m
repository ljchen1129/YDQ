//
//  UIView+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIView+SYHelper.h"

@implementation UIView (SYHelper)

/// 设置UI视图的边框属性
- (void)layerWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (radius > 0.0)
    {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    }
    
    if (color && width > 0.0)
    {
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = width;
    }
}

#pragma mark - 解摸手势

/// 单击，或双击响应
- (void)tapRecognizer:(NSInteger)tapNumber action:(void (^)(UITapGestureRecognizer *recognizer))action
{
    [UIGestureRecognizer tapRecognizer:self tapNumber:tapNumber action:action];
}

// 长按手势（长按时间默认0.5）
- (void)longPressRecognizer:(CFTimeInterval)time action:(void (^)(UILongPressGestureRecognizer *recognizer))action
{
    [UIGestureRecognizer longPressRecognizer:self minimumPressDuration:time action:action];
}

- (void)panRecognizer:(void (^)(UIPanGestureRecognizer *recognizer))action
{
    [UIGestureRecognizer panRecognizer:self action:action];
}

- (void)pinchRecognizer:(void (^)(UIPinchGestureRecognizer *recognizer))action
{
    [UIGestureRecognizer pinchRecognizer:self action:action];
}

- (void)swipeRecognizer:(UISwipeGestureRecognizerDirection)direction action:(void (^)(UISwipeGestureRecognizer *recognizer))action
{
    [UIGestureRecognizer swipeRecognizer:self direction:direction action:action];
}

- (void)rotationRecognizer:(void (^)(UIRotationGestureRecognizer *recognizer))action
{
    [UIGestureRecognizer rotationRecognizer:self action:action];
}


@end
