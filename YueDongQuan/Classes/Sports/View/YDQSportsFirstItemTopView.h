//
//  YDQSportsFirstItemTopView.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//  第一个 item 最上面的 view

#import <UIKit/UIKit.h>

@interface YDQSportsFirstItemTopView : UIView

/// 天气点击回调
@property(nonatomic, copy) void (^weatherClickCallBack) (void);

/// 钥匙点击回调
@property(nonatomic, copy) void (^keyBtnClickCallBack) (void);

/// 红包点击回调
@property(nonatomic, copy) void (^redbagBtnClickCallBack) (void);

/// 等级点击回调
@property(nonatomic, copy) void (^levelBtnClickCallBack) (void);

+ (instancetype)initFromNib;

@end
