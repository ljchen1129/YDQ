//
//  YDQSportsBottomSportsDataCell.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomSportsDataCell.h"

@interface YDQSportsBottomSportsDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UIButton *sportDataBtn;

@end

@implementation YDQSportsBottomSportsDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    [self setUI];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index
{
    YDQSportsBottomSportsDataCell *cell = [tableView dequeueReusableCellWithIdentifier:YDQSportsBottomSportsDataCellIdentifierId forIndexPath:index];
    if (cell == nil)
    {
        cell = [[YDQSportsBottomSportsDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDQSportsBottomSportsDataCellIdentifierId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    
    return self;
}

# pragma mark - UI

- (void)setUI
{
    self.contentView.backgroundColor = YDQSprotsBottomSportsDataCellBg;
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - eventResponse

- (IBAction)sportsDataBtnClick:(UIButton *)sender
{
    if (_sportsDataBtnClick)
    {
        _sportsDataBtnClick();
    }
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 10;
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

@end
