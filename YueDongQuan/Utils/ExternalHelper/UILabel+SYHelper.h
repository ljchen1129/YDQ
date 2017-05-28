//
//  UILabel+SYHelper.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/1/30.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自适应大小类型（宽高，或宽）
typedef NS_ENUM(NSInteger, labelAutoSizeType)
{
    /// 自适应宽
    labelAutoSizeHorizontal = 1,
    
    /// 自适应宽高
    labelAutoSizeAll
};

@interface UILabel (SYHelper)

/// 设置自适应标签宽高
- (void)labelAutoSize:(labelAutoSizeType)type;

@end
