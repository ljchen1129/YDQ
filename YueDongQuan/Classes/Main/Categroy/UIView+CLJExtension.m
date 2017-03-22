//
//  UIView+YDQExtension.m
//  Baisibudejie
//
//  Created by 陈良静 on 2017/3/3.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "UIView+CLJExtension.h"

@implementation UIView (CLJExtension)

- (void)setClj_width:(CGFloat)clj_width
{
    CGRect frame = self.frame;
    frame.size.width = clj_width;
    self.frame = frame;
}

- (void)setClj_height:(CGFloat)clj_height
{
    CGRect frame = self.frame;
    frame.size.height = clj_height;
    self.frame = frame;
}

- (void)setClj_x:(CGFloat)clj_x
{
    CGRect frame = self.frame;
    frame.origin.x = clj_x;
    self.frame = frame;
}

- (void)setClj_y:(CGFloat)clj_y
{
    CGRect frame = self.frame;
    frame.origin.y = clj_y;
    self.frame = frame;
}

- (void)setClj_size:(CGSize)clj_size
{
    CGRect frame = self.frame;
    frame.size = clj_size;
    self.frame = frame;
}

- (CGFloat)clj_width
{
    return self.frame.size.width;
}

- (CGFloat)clj_height
{
    return self.frame.size.height;
}

- (CGFloat)clj_x
{
    return self.frame.origin.x;
}

- (CGFloat)clj_y
{
    return self.frame.origin.y;
}

- (CGSize)clj_size
{
    return self.frame.size;
}

@end
