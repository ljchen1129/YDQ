//
//  SportsTopViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsTopViewController.h"
#import "YDQMainPageTitleView.h"
#import "YDQMainPageContentView.h"
#import "YDQSportsFirstItemTopView.h"

#import "YDQWeatherViewController.h"
#import "YDQKeyViewController.h"
#import "YDQRedbagViewController.h"
#import "YDQLevelViewController.h"

static CGFloat const kTitleViewX = 50.0;
static CGFloat const kTitleViewY = 100.0;
static CGFloat const kTitleViewH = 35.0;
static CGFloat const kContentViewY = kTitleViewY + kTitleViewH;

@interface YDQSportsTopViewController () <PageTitleViewDelegate, PageContentViewDelegate>

/// firstItemTopView
@property(nonatomic, strong) YDQSportsFirstItemTopView *firstItemTopView;

///topTitleView
@property(nonatomic, strong) YDQMainPageTitleView *titleView;

/// contentView
@property(nonatomic, strong) YDQMainPageContentView *contentView;

/// 当前运动类型
@property(nonatomic, assign) SportsType currentSportType;

@end

@implementation YDQSportsTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
}

#pragma mark - UI

- (void)setupUI
{
    // 1.不要调整UIScrollView的内边距，不然系统会自动将scrollView的y坐标加64
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 2. 添加firstItemTopView
    [self.view addSubview:self.firstItemTopView];
    self.firstItemTopView.frame = CGRectMake(0, kStatusHeight, YDQScreenWidth, 44.0);
    
    @CLJWeakSelf;
    self.firstItemTopView.weatherClickCallBack = ^{
        YDQWeatherViewController *weatherVc = [[YDQWeatherViewController alloc] init];
        [weakself.navigationController pushViewController:weatherVc animated:YES];
    };
    
    self.firstItemTopView.keyBtnClickCallBack = ^{
        YDQKeyViewController *keyVc = [[YDQKeyViewController alloc] init];
        [weakself.navigationController pushViewController:keyVc animated:YES];
    };
    
    self.firstItemTopView.redbagBtnClickCallBack = ^{
        YDQRedbagViewController *redbagVc = [[YDQRedbagViewController alloc] init];
        [weakself.navigationController pushViewController:redbagVc animated:YES];
    };
    
    self.firstItemTopView.levelBtnClickCallBack = ^{
        YDQLevelViewController *levelVc = [[YDQLevelViewController alloc] init];
        [weakself.navigationController pushViewController:levelVc animated:YES];
    };
    
    // 3. 添加titleView
    [self.view addSubview:self.titleView];
    
    // 4.添加contentView
    [self.view addSubview:self.contentView];
    
    // 5.向上的箭头
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:arrowBtn];
    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"icon_index_slideup"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(slidup) forControlEvents:UIControlEventTouchUpInside];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0.0);
        make.bottom.mas_equalTo(-10.0 - 49);
        make.size.mas_equalTo(CGSizeMake(23.0, 23.0));
    }];
}

#pragma mark - eventResponse

- (void)slidup
{
    YDQLog(@"slidup-----%ld", self.currentSportType);
    
    if (_slidUpCallBack)
    {
        _slidUpCallBack(self.currentSportType);
    }
}

#pragma mark - PageTitleViewDelegate

- (void)pageTitleView:(UIView *)pageTitleView selectedIndex:(int)index
{
    self.currentSportType = index;
    [self.contentView setCurrentIndex:index];
}

#pragma mark - PageContentViewDelegate

- (void)pageContentView:(UIView *)pageContentView ScrollSourceIndex:(int)sourceIndex targetIndex:(int)targetIndex progress:(CGFloat)progress
{
    self.currentSportType = targetIndex;
    [self.titleView resetTitleViewWithSourceIndex:sourceIndex targetIndex:targetIndex progress:progress];
}

#pragma mark - setter

- (YDQMainPageContentView *)contentView
{
    if (!_contentView)
    {
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int i = 0; i < 4; ++i)
        {
            UIViewController *childVc = [[UIViewController alloc] init];
            UILabel *label = [[UILabel alloc] init];
            label.center = childVc.view.center;
            label.text = [NSString stringWithFormat:@"第%d页", i];
            [label sizeToFit];
            [childVc.view addSubview:label];
            childVc.view.backgroundColor = YDQRandomColor;
            [tempArray addObject:childVc];
        }
        
        CGRect frame = CGRectMake(0, kContentViewY, YDQScreenWidth, YDQScreenHeight - kContentViewY);
        _contentView = [[YDQMainPageContentView alloc] initWithFrame:frame controllers:tempArray parnentVc:self];
        _contentView.delegate = self;
    }
    
    return _contentView;
}

- (YDQMainPageTitleView *)titleView
{
    if (!_titleView)
    {
        CGRect frame = CGRectMake(kTitleViewX, kTitleViewY, self.view.clj_width - 2 * kTitleViewX, kTitleViewH);
        _titleView = [[YDQMainPageTitleView alloc] initWithFrame:frame titles:@[@"计步", @"跑步", @"健身", @"骑行"]];
        _titleView.delegate = self;
    }
    
    return _titleView;
}

- (YDQSportsFirstItemTopView *)firstItemTopView
{
    if (!_firstItemTopView)
    {
        _firstItemTopView = [YDQSportsFirstItemTopView initFromNib];
    }
    
    return _firstItemTopView;
}

@end
