//
//  SportsTopViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/8.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "SportsTopViewController.h"
#import "MainPageTitleView.h"
#import "MainPageContentView.h"

static CGFloat const kTitleViewX = 50.0;
static CGFloat const kTitleViewY = 100.0;
static CGFloat const kTitleViewH = 35.0;
static CGFloat const kContentViewY = kTitleViewY + kTitleViewH;

@interface SportsTopViewController () <PageTitleViewDelegate, PageContentViewDelegate>

///topTitleView
@property(nonatomic, strong) MainPageTitleView *titleView;

/// contentView
@property(nonatomic, strong) MainPageContentView *contentView;

@end

@implementation SportsTopViewController

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
    
    // 2. 添加titleView
    [self.view addSubview:self.titleView];
    
    // 3.添加contentView
    [self.view addSubview:self.contentView];
}

#pragma mark - PageTitleViewDelegate

- (void)pageTitleView:(UIView *)pageTitleView selectedIndex:(int)index
{
    [self.contentView setCurrentIndex:index];
}

#pragma mark - PageContentViewDelegate

- (void)pageContentView:(UIView *)pageContentView ScrollSourceIndex:(int)sourceIndex targetIndex:(int)targetIndex progress:(CGFloat)progress
{
    [self.titleView resetTitleViewWithSourceIndex:sourceIndex targetIndex:targetIndex progress:progress];
}

#pragma mark - setter

- (MainPageContentView *)contentView
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
            childVc.view.backgroundColor = CLJRandomColor;
            [tempArray addObject:childVc];
        }
        
        CGRect frame = CGRectMake(0, kContentViewY, CLJScreenWidth, CLJScreenHeight - kContentViewY);
        _contentView = [[MainPageContentView alloc] initWithFrame:frame controllers:tempArray parnentVc:self];
        _contentView.delegate = self;
    }
    
    return _contentView;
}

- (MainPageTitleView *)titleView
{
    if (!_titleView)
    {
        CGRect frame = CGRectMake(kTitleViewX, kTitleViewY, self.view.clj_width - 2 * kTitleViewX, kTitleViewH);
        _titleView = [[MainPageTitleView alloc] initWithFrame:frame titles:@[@"计步", @"跑步", @"健身", @"骑行"]];
        _titleView.delegate = self;
    }
    
    return _titleView;
}

@end
