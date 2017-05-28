//
//  YDQWeatherViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQWeatherViewController.h"

@interface YDQWeatherViewController ()

@end

@implementation YDQWeatherViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"黄历天气";
    
    self.view.backgroundColor = UIRandomColor;
    
    DLog(@"%@",self.navigationController.childViewControllers);
}



@end
