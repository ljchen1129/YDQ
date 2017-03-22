//
//  YDQSportsBottomTableHearder.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomTableHeader.h"

@implementation YDQSportsBottomTableHeader

+ (instancetype)headerWithTableView:(UITableView *)tableView
{
    YDQSportsBottomTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:YDQSportsBottomTableHeaderIndetifierId];
    if (header == nil)
    {
        header = [[YDQSportsBottomTableHeader alloc] initWithReuseIdentifier:YDQSportsBottomTableHeaderIndetifierId];
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
    self.contentView.backgroundColor = YDQSprotsTableCellBg;
    
    // 向下的箭头
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:arrowBtn];
    
    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"icon_index_slidedown"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(slidDown) forControlEvents:UIControlEventTouchUpInside];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0.0);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(23.0, 23.0));
    }];
    
    // 分享步数/开始跑步/开始健身/开始骑行 按钮
    UIButton *doSportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:doSportBtn];
    [doSportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13.0);
        make.bottom.mas_equalTo(-13.0);
        make.size.mas_equalTo(CGSizeMake(80.0, 40.0));
    }];
    
    doSportBtn.backgroundColor = YDQButtonBg;
    [doSportBtn setTitle:@"分享步数" forState:UIControlStateNormal];
    [doSportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doSportBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [doSportBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    doSportBtn.layer.cornerRadius = 20.0;
    doSportBtn.layer.masksToBounds = YES;
}

#pragma mark - eventResponse

- (void)slidDown
{
    if (_sildDown)
    {
        _sildDown();
    }
}

- (void)btnClick
{
    YDQLog(@"分享步数");
}

@end
