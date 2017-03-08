//
//  SportsViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/7.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "SportsViewController.h"
#import "SportsContainerView.h"
#import "SportsTopViewController.h"
#import "SportsBottomViewController.h"

@interface SportsViewController () <UINavigationControllerDelegate>

/// contentView
@property(nonatomic, strong) SportsContainerView *contentView;

@end

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
//    self.view.backgroundColor = CLJRandomColor;
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

- (SportsContainerView *)contentView
{
    if (!_contentView)
    {
        NSMutableArray *tempArray = [NSMutableArray array];
        SportsTopViewController *topVc = [[SportsTopViewController alloc] init];
        [tempArray addObject:topVc];
        topVc.view.backgroundColor = CLJRandomColor;
        SportsBottomViewController *bottomVc = [[SportsBottomViewController alloc] init];
        [tempArray addObject:bottomVc];
        
        _contentView = [[SportsContainerView alloc] initWithFrame:self.view.bounds controllers:tempArray parnentVc:self];
    }
    
    return _contentView;
}

@end
