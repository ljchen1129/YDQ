//
//  YDQSportsBottomTableSectionHeader.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/31.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomTableSectionHeader.h"

@interface YDQSportsBottomTableSectionHeader()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation YDQSportsBottomTableSectionHeader

+ (instancetype)headerWithTableView:(UITableView *)tableView
{
    YDQSportsBottomTableSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:YDQSportsBottomTableSectionHeaderIndentifierId];
    if (header == nil)
    {
        header = [[YDQSportsBottomTableSectionHeader alloc] initWithReuseIdentifier:YDQSportsBottomTableSectionHeaderIndentifierId];
    }
    
    return header;
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
    // 1. section视图
    UIView *sectionView = [[UIView alloc] init];
    sectionView.alpha = 0.01;
    [self.contentView addSubview:sectionView];
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0.0);
        make.height.mas_offset(10.0);
    }];
    
    // 2. container 视图
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = YDQSprotsTableCellBg;
    [self.contentView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0.0);
        make.top.mas_offset(10.0);
    }];
    
    [containerView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10.0);
        make.centerY.mas_offset(0.0);
    }];
}

#pragma mark - setter

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.textLabel.text = _title;
}

#pragma mark - getter

- (UILabel*)textLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

@end
