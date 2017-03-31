//
//  YDQSportsBottomNewAchievementCell.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/23.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomNewAchievementCell.h"

@interface YDQSportsBottomNewAchievementCell ()

@property (weak, nonatomic) IBOutlet UIImageView *redbagImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *receivedRedbagLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIView *sepLine;

@end

@implementation YDQSportsBottomNewAchievementCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    [self setUI];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index
{
    YDQSportsBottomNewAchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:YDQSportsBottomNewAchievementCellIdentifierId forIndexPath:index];
    if (cell == nil)
    {
        cell = [[YDQSportsBottomNewAchievementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDQSportsBottomNewAchievementCellIdentifierId];
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = YDQSprotsBottomNewAchievementCellBg;
    self.backgroundColor = YDQClearColor;
    
    //    self.redbagImageView.image = [UIImage imageNamed:@""];
    self.subTitleLabel.textColor = YDQRGBColor(169, 187, 159);
    self.receivedRedbagLabel.textColor = YDQRGBColor(169, 187, 159);
    self.progressLabel.textColor = YDQRGBColor(169, 187, 159);
    self.progress.trackTintColor = YDQRGBColor(74, 105, 117);
    self.progress.progressTintColor = YDQButtonBg;
    self.sepLine.backgroundColor = [UIColor lightGrayColor];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 1;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
