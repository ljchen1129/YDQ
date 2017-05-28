//
//  UIButton+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/11.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UIButton+SYHelper.h"

@implementation UIButton (SYHelper)

/// 图片与标题显示样式
- (void)buttonStyle:(ButtonStyle)style  offSet:(CGFloat)offset
{
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    // image中心移动的x距离
    CGFloat imageOringinX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    // image中心移动的y距离
    CGFloat imageOriginY = imageHeight / 2 + offset / 2;
    // label中心移动的x距离
    CGFloat labelOriginX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    // label中心移动的y距离
    CGFloat labelOriginY = labelHeight / 2 + offset / 2;
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + offset - tempHeight;
    
    switch (style)
    {
        case ButtonStyleDefault:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, (-offset / 2), 0.0, (offset / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, (offset / 2), 0.0, (-offset / 2));
            self.contentEdgeInsets = UIEdgeInsetsMake(0.0, (offset / 2), 0.0, (offset / 2));
        }
            break;
        case ButtonStyleImageRightTextLeftHorizontalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, (labelWidth + offset / 2), 0.0, -(labelWidth + offset / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(imageWidth + offset / 2), 0.0, (imageWidth + offset / 2));
            self.contentEdgeInsets = UIEdgeInsetsMake(0.0, offset / 2, 0.0, offset / 2);
        }
            break;
        case ButtonStyleCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, imageOringinX, 0.0, -imageOringinX);
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -labelOriginX, 0.0, labelOriginX);
            self.contentEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        }
            break;
        case ButtonStyleImageUpTextDownVerticalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOriginY, imageOringinX, imageOriginY, -imageOringinX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOriginY, -labelOriginX, -labelOriginY, labelOriginX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOriginY, (-changedWidth / 2), (changedHeight - imageOriginY), (-changedWidth / 2));
        }
            break;
        case ButtonStyleImageDownTextUpVerticalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOriginY, imageOringinX, -imageOriginY, -imageOringinX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOriginY, -labelOriginX, labelOriginY, labelOriginX);
            self.contentEdgeInsets = UIEdgeInsetsMake((changedHeight - imageOriginY), (-changedWidth / 2), imageOriginY, (-changedWidth / 2));
        }
            break;
            
        default:
            break;
    }
}


@end
