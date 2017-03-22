//
//  MainTabBarVC.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/7.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQMainTabBarVC.h"

@interface YDQMainTabBarVC ()

@end

@implementation YDQMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatViewControllerWithStoryboard:@"Sports"];
    [self creatViewControllerWithStoryboard:@"Challenge"];
    [self creatViewControllerWithStoryboard:@"Explore"];
    [self creatViewControllerWithStoryboard:@"Social"];
    [self creatViewControllerWithStoryboard:@"Profile"];
}

// 通过Storyboard添加子控制器
- (void)creatViewControllerWithStoryboard:(NSString *)storyboard
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    [self addChildViewController:vc];
}

@end
