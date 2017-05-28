//
//  YDQSportsBottomTableSectionFooter.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/31.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomTableSectionFooter.h"

@interface YDQSportsBottomTableSectionFooter()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation YDQSportsBottomTableSectionFooter

+ (instancetype)footerWithTableView:(UITableView *)tableView
{
    YDQSportsBottomTableSectionFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:YDQSportsBottomTableSectionFooterIndentifierId];
    if (footer == nil)
    {
        footer = [[YDQSportsBottomTableSectionFooter alloc] initWithReuseIdentifier:YDQSportsBottomTableSectionFooterIndentifierId];
    }
    
    return footer;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUI];
    }
    
    return self;
}

#pragma mark - UI

- (void)setUI
{
    self.contentView.backgroundColor = YDQSprotsTableCellBg;
    [self.contentView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0.0);
    }];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    self.userInteractionEnabled = YES;
    self.contentView.userInteractionEnabled = YES;
    [self.contentView addGestureRecognizer:gesture];
}

- (void)click
{
    if (_footerClick)
    {
        _footerClick(self.title);
    }
}

#pragma mark - setter

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.textLabel.text = _title;
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 1;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

#pragma mark - getter

- (UILabel*)textLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = UIColorRGB(83, 102, 106);
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

@end
