//
//  SportsTopTitleView.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQMainPageTitleView.h"

static CGFloat const kScrollLineW = 20.0;
static CGFloat const kScrollLineH = 2.0;
static int const kLabelTag = 2000;
static NSTimeInterval const kDurationTime = 0.15;

#define kNormalColor @{@"red":@255, @"green":@255, @"blue":@255}
#define kSelectedColor @{@"red":@42, @"green":@190, @"blue":@43}

@interface YDQMainPageTitleView ()

/// titles数组
@property(nonatomic, strong) NSArray *titles;

/// scrollView
@property(nonatomic, strong) UIScrollView *scrollView;

/// titleLable数组
@property(nonatomic, strong) NSMutableArray *titleLabels;

/// scrollLine
@property(nonatomic, strong) UIView *scrollLine;

/// 保存当前点击label的索引
@property(nonatomic, assign) int currentIndex;

@end

@implementation YDQMainPageTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *> *)titles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titles = titles;
        
        [self setupUI];
    }
    
    return self;
}


#pragma mark - UI

- (void)setupUI
{
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
    
    [self setupTitleLabels];
    
    [self setupScrollLine];
}

// 设置lables
- (void)setupTitleLabels
{
    CGFloat labelW = self.clj_width / self.titles.count;
    CGFloat labelH = self.clj_height;
    
    for (int i = 0; i < self.titles.count; i++)
    {
        UILabel *label = [[UILabel alloc] init];
        NSString *text = self.titles[i];
        label.text = text;
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = UIColorRGB([kNormalColor[@"red"] intValue], [kNormalColor[@"green"] intValue], [kNormalColor[@"blue"] intValue]);
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = kLabelTag + i;
        
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        
        self.userInteractionEnabled = YES;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableTapClick:)];
        [label addGestureRecognizer:tapGes];
        
        [self.scrollView addSubview:label];
        [self.titleLabels addObject:label];
    }
}

// 设置滑块
- (void)setupScrollLine
{
    UILabel *fristLable = [self.titleLabels firstObject];
    fristLable.textColor = UIColorRGB([kSelectedColor[@"red"] intValue], [kSelectedColor[@"green"] intValue], [kSelectedColor[@"blue"] intValue]);
    CGFloat scrollLineX = fristLable.clj_x + (fristLable.clj_width - kScrollLineW) / 2;
    self.scrollLine = [[UIView alloc] initWithFrame:CGRectMake(scrollLineX, fristLable.clj_height - kScrollLineH, kScrollLineW, kScrollLineH)];
    self.scrollLine.backgroundColor = [UIColor orangeColor];

    [self.scrollView addSubview:self.scrollLine];
}

#pragma mark - publicMethod

- (void)resetTitleViewWithSourceIndex:(int)sourceIndex targetIndex:(int)targetIndex progress:(CGFloat)progress
{
    // 1. 取出label
    UILabel *sourceLabel = self.titleLabels[sourceIndex];
    UILabel *targetLabel = self.titleLabels[targetIndex];
    
    // 2. 滑块滑动逻辑
    CGFloat moveTotalX = targetLabel.center.x - sourceLabel.center.x;
    CGFloat moveX = moveTotalX * progress;
    
    CGPoint tempPoint = self.scrollLine.center;
    tempPoint.x = sourceLabel.center.x + moveX;
    self.scrollLine.center = tempPoint;
    
    // 3. 颜色渐变
    // 颜色变化范围
    CGFloat redDelta = ([kNormalColor[@"red"] intValue] - [kSelectedColor[@"red"] intValue]) * progress;
    CGFloat greenDelta = ([kNormalColor[@"green"] intValue] - [kSelectedColor[@"green"] intValue]) * progress;
    CGFloat blueDelta = ([kNormalColor[@"blue"] intValue] - [kSelectedColor[@"blue"] intValue]) * progress;
    
    // 注意：sourceLabel 和 targetLabel的颜色设置不能调换顺序
    sourceLabel.textColor = UIColorRGB([kSelectedColor[@"red"] intValue] + redDelta, [kSelectedColor[@"green"] intValue] + greenDelta, [kSelectedColor[@"blue"] intValue] + blueDelta);
    targetLabel.textColor = UIColorRGB([kNormalColor[@"red"] intValue] - redDelta, [kNormalColor[@"green"] intValue] - greenDelta, [kNormalColor[@"blue"] intValue] - blueDelta);
    
    // 4.更新当前索引
    self.currentIndex = targetIndex;
}

#pragma mark - eventResponse

- (void)lableTapClick:(UITapGestureRecognizer *)gesture
{
    UILabel *currentlabel = (UILabel *)gesture.view;
    currentlabel.textColor = UIColorRGB([kSelectedColor[@"red"] intValue], [kSelectedColor[@"green"] intValue], [kSelectedColor[@"blue"] intValue]);
    [UIView animateWithDuration:kDurationTime animations:^{
        self.scrollLine.clj_x = currentlabel.center.x - kScrollLineW / 2;
    }];

    // 获取之前的label
    UILabel *oldLabel = self.titleLabels[self.currentIndex];
    oldLabel.textColor = UIColorRGB([kNormalColor[@"red"] intValue], [kNormalColor[@"green"] intValue], [kNormalColor[@"blue"] intValue]);
    
    // 保存最新的索引值
    self.currentIndex = (int)(currentlabel.tag - kLabelTag);
    
    // 将选中的索引传递出去
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)])
    {
        [self.delegate pageTitleView:self selectedIndex:self.currentIndex];
    }
}

#pragma mark - setter

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
    }
    
    return _scrollView;
}

- (NSMutableArray *)titleLabels
{
    if (!_titleLabels)
    {
        _titleLabels = [NSMutableArray arrayWithCapacity:4];
    }
    
    return _titleLabels;
}

@end
