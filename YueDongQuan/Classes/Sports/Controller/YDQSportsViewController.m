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

@end

@implementation YDQSportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
//    self.view.backgroundColor = YDQRandomColor;
    // 1.不要调整UIScrollView的内边距，不然系统会自动将scrollView的y坐标加64
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        NSMutableArray *tempArray = [NSMutableArray array];
        YDQSportsTopViewController *topVc = [[YDQSportsTopViewController alloc] init];
        [tempArray addObject:topVc];
        topVc.view.backgroundColor = YDQRandomColor;
        YDQSportsBottomViewController *bottomVc = [[YDQSportsBottomViewController alloc] init];
        [tempArray addObject:bottomVc];
        
        _contentView = [[YDQSportsContainerView alloc] initWithFrame:self.view.bounds controllers:tempArray parnentVc:self];
    }
    
    return _contentView;
}

@end
