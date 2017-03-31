//
//  SportsViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/7.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsViewController.h"
#import "YDQSportsContainerView.h"
#import "YDQSportsTopViewController.h"
#import "YDQSportsBottomViewController.h"

@interface YDQSportsViewController () <UINavigationControllerDelegate>

/// contentView
@property(nonatomic, strong) YDQSportsContainerView *contentView;

/// YDQSportsTopViewController
@property(nonatomic, strong) YDQSportsTopViewController *topVc;

/// YDQSportsBottomViewController
@property(nonatomic, strong) YDQSportsBottomViewController *bottomVc;

@end

@implementation YDQSportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = YDQRGBColor(43, 89, 118);
    [self.view addSubview:self.contentView];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - setter

- (YDQSportsContainerView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[YDQSportsContainerView alloc] initWithFrame:self.view.bounds controllers:@[self.topVc, self.bottomVc] parnentVc:self];
        @CLJWeakSelf
        _contentView.slidUpCallBack = ^(SportsType type){
            weakself.bottomVc.sportsType = type;
        };
    }
    
    return _contentView;
}

- (YDQSportsTopViewController *)topVc
{
    if (!_topVc)
    {
        _topVc = [[YDQSportsTopViewController alloc] init];
        @CLJWeakSelf
        _topVc.slidUpCallBack = ^(SportsType type){
            [weakself.contentView setCurrentIndex:1];
            weakself.bottomVc.sportsType = type;
        };
        
        _topVc.changeSportsType = ^(SportsType type) {
            weakself.view.backgroundColor = YDQRandomColor;
        };
    }
    
    return _topVc;
}

- (YDQSportsBottomViewController *)bottomVc
{
    if (!_bottomVc)
    {
        _bottomVc = [[YDQSportsBottomViewController alloc] init];
        _bottomVc.view.backgroundColor = YDQClearColor;
        @CLJWeakSelf
        _bottomVc.slidDown = ^{
            [weakself.contentView setCurrentIndex:0];
        };
    }
    
    return _bottomVc;
}

@end
