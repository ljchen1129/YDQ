//
//  UILabel+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "UILabel+SYHelper.h"

@implementation UILabel (SYHelper)

/// 设置自适应标签宽高
- (void)labelAutoSize:(labelAutoSizeType)type
{
    [self setNumberOfLines:0];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = CGSizeMake(self.clj_size.width, CGFLOAT_MAX);
    CGSize labelsize = [self.text sizeWithFont:self.font constrainedToSize:size lineBreakMode:self.lineBreakMode];
    if (labelAutoSizeHorizontal == type)
    {
        self.frame = CGRectMake(self.clj_x, self.clj_y, labelsize.width, self.clj_height);
    }
    else if (labelAutoSizeAll == type)
    {
        self.frame = CGRectMake(self.clj_x, self.clj_y, labelsize.width, labelsize.height);
    }
}

@end
