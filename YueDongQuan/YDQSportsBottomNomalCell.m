//
//  YDQSportsBottomNomalCell.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomNomalCell.h"

@implementation YDQSportsBottomNomalCell
+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index
{
    YDQSportsBottomNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:YDQSportsBottomNomalCellIdentifierId forIndexPath:index];
    if (cell == nil)
    {
        cell = [[YDQSportsBottomNomalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDQSportsBottomNomalCellIdentifierId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUI];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10.0);
        make.height.mas_equalTo(60.0);
        make.width.mas_equalTo(75.0);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.imageView).offset(0.0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(YDQSportsBottomNomalCellHeight);
    }];
}

# pragma mark - UI

- (void)setUI
{
    self.contentView.backgroundColor = UIColorRGB(67, 86, 82);
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.imageView.image = [UIImage imageNamed:@"train_daily"];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.text = @"上周累计消耗卡路里150千卡，等一0.8个鸡腿";
    self.textLabel.font = [UIFont systemFontOfSize:16.0];
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 1.0;
    frame.size.height -= 1.0;
    
    [super setFrame:frame];
}

@end
