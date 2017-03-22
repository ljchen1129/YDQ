//
//  YDQSportsFirstItemTopView.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsFirstItemTopView.h"

@interface YDQSportsFirstItemTopView ()

@property (weak, nonatomic) IBOutlet UIView *weather;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;
@property (weak, nonatomic) IBOutlet UIButton *keyBtn;
@property (weak, nonatomic) IBOutlet UIButton *redbagBtn;

@end

@implementation YDQSportsFirstItemTopView

+ (instancetype)initFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
    self.weather.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weatherlick)];
    [self.weather addGestureRecognizer:tap];
}

#pragma mark - eventResponse

- (void)weatherlick
{
    if (_weatherClickCallBack)
    {
        _weatherClickCallBack();
    }
}

- (IBAction)levelBtnClick:(UIButton *)sender
{
    if (_levelBtnClickCallBack)
    {
        _levelBtnClickCallBack();
    }
}

- (IBAction)keyBtnClick:(UIButton *)sender
{
    if (_keyBtnClickCallBack)
    {
        _keyBtnClickCallBack();
    }
}

- (IBAction)redbagBtnClick:(UIButton *)sender
{
    if (_redbagBtnClickCallBack)
    {
        _redbagBtnClickCallBack();
    }
}



@end
