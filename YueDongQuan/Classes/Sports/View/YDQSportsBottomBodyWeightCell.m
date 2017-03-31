//
//  YDQSportsBottomBodyWeightCell.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomBodyWeightCell.h"

@interface YDQSportsBottomBodyWeightCell ()

@property (weak, nonatomic) IBOutlet UIView *labelBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *conentLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyFatLabel;

@end

@implementation YDQSportsBottomBodyWeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUI];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index
{
    YDQSportsBottomBodyWeightCell *cell = [tableView dequeueReusableCellWithIdentifier:YDQSportsBottomBodyWeightCellIdentifierId forIndexPath:index];
    if (cell == nil)
    {
        cell = [[YDQSportsBottomBodyWeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDQSportsBottomBodyWeightCellIdentifierId];
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
    self.labelBackgroundView.backgroundColor = YDQRGBColor(58, 78, 76);
    self.labelBackgroundView.layer.cornerRadius = 10.0;
    self.labelBackgroundView.layer.masksToBounds = YES;
    
    self.contentView.backgroundColor = YDQSprotsBottomBodyWeightCellBg;
    self.backgroundColor = YDQClearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - eventResponse

- (IBAction)goWeightManager:(UIButton *)sender
{
    if (_goWeightManagerClick)
    {
        _goWeightManagerClick();
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
