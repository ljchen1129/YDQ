//
//  YDQSportsBottomSportsDrys.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/31.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsBottomSportsDrysCell.h"

@interface YDQSportsBottomSportsDrysCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation YDQSportsBottomSportsDrysCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.contentView.backgroundColor = YDQSprotsTableCellBg;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    YDQSportsBottomSportsDrysCell *cell = [tableView dequeueReusableCellWithIdentifier:YDQSportsBottomSportsDrysCellIndentifierId];
    if (cell == nil)
    {
        cell = [[YDQSportsBottomSportsDrysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDQSportsBottomSportsDrysCellIndentifierId];
    }
    
    return cell;
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 1.0;
    frame.size.height -= 1.0;
    
    [super setFrame:frame];
}

@end
