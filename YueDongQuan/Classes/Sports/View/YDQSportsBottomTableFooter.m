//
//  YDQSportsBottomTableFooter.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/31.
//  Copyright © 2017年 陈良静. All rights reserved.
//  

#import "YDQSportsBottomTableFooter.h"

static NSString *const kLabelTitle = @"走路跑步领红包";

@interface YDQSportsBottomTableFooter ()

/// icon
@property(nonatomic, strong) UIImageView *icon;
/// label
@property(nonatomic, strong) UILabel *label;

@end

@implementation YDQSportsBottomTableFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUI];
    }
    
    return self;
}

- (void)setUI
{
    self.backgroundColor = YDQSprotsTableCellBg;
    self.alpha = 0.2;
    
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0.0);
        make.left.mas_offset(140.0);
    }];
    [self.icon sizeToFit];

    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0.0);
        make.left.mas_equalTo(self.icon.mas_right).offset(5.0);
    }];
}

#pragma mark- setter

- (void)setIconName:(NSString *)iconName
{
    _iconName = iconName;
    self.icon.image = [UIImage imageNamed:_iconName];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.label.text = _title;
}

#pragma mark - getter

- (UIImageView*)icon
{
    if (!_icon)
    {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"caution"];
    }
    
    return _icon;
}

- (UILabel*)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor whiteColor];
        _label.text = kLabelTitle;
        _label.font = [UIFont systemFontOfSize:10.0];
    }
    
    return _label;
}

@end
