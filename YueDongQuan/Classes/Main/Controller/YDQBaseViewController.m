//
//  YDQBaseViewController.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/3/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQBaseViewController.h"

@interface YDQBaseViewController ()

@end

@implementation YDQBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
//    [HUDManager hiddenHUD];
    
    if ([self isRootController])
    {
        self.hidesBottomBarWhenPushed = NO;
    }
    else
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // 显示系统返回按钮
    if (!self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem = [self isRootController] ? nil : [self barBackButtonWithImage:[UIImage imageNamed: @"arrow_left_green"] image:nil title:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (ISIOS7)
    {
        if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent)
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
}

- (void)loadView
{
    [super loadView];
    
//    self.view.backgroundColor = kColorBackground;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    if (ISIOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        // 不要调整 UIScrollView 的内边距，不然系统会自动将 scrollView 的 y 坐标加 64
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
//    [HUDManager hiddenHUD];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //    [BaseIceModel requestRelease];
    YDQLog(@"%@释放了",NSStringFromClass([self class]));
}

#pragma mark - 异常判断

//// 判断登录，延迟变更tabbar视图
//- (void)loginVerifySuccess:(void (^)())success
//{
//    [self loginVerify:NO success:success];
//}

/// 判断登录，是否立即，或延迟变更tabbar视图（延迟时，在返回最顶层时改变）
//- (void)loginVerify:(BOOL)changTabNow success:(void (^)(void))success
//{
//    if (GetDataManager.isLogin)
//    {
//        if (success)
//        {
//            success();
//        }
//    }
//    else
//    {
//        LoginVC *login = [[LoginVC alloc] init];
//        login.completionBack = [success copy];
//        SYNavigationController *loginNav = [[SYNavigationController alloc] initWithRootViewController:login];
//        [self presentViewController:loginNav animated:YES completion:nil];
//    }
//}

#pragma mark- 网络加载视图

- (void)refreshClick
{
    
}

- (void)loadData
{
    
}

- (void)loadData:(BOOL)isFirst
{
    
}

- (void)loadDataWithPage:(int)page
{
    
}

- (void)loadDataWithPage:(int)page loadFirst:(BOOL)isFirst
{
    
}

- (void)loadMoreData
{
    
}

#pragma mark - 加载状态视图


#pragma mark - 点击空白收键盘

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 网络操作的添加和释放

//- (NSMutableDictionary *)networkDicts
//{
//    if (!_networkDicts)
//    {
//        _networkDicts = [[NSMutableDictionary alloc] init];
//    }
//    
//    return _networkDicts;
//}

//- (void)addNet:(MKNetworkOperation *)net
//{
//    if ([net isKindOfClass:[MKNetworkOperation class]])
//    {
//        NSString *key = NSStringFromClass([self class]);
//        [self.networkDicts setObject:net forKey:key];
//    }
//}

//- (void)releaseNet
//{
//    for (NSString *key in self.networkDicts.allKeys)
//    {
//        MKNetworkOperation *net = [self.networkDicts objectForKey:key];
//        if ([net isKindOfClass:[MKNetworkOperation class]])
//        {
//            [net cancel];
//        }
//    }
//    
//    [self.networkDicts removeAllObjects];
//    
//    [HUDManager hiddenHUD];
//    [iToast hiddenIToast];
//}

//- (void)releaseNetWithTarget:(id)target
//{
//    if (target)
//    {
//        NSString *key = NSStringFromClass([target class]);
//        
//        MKNetworkOperation *net = [self.networkDicts objectForKey:key];
//        [net cancel];
//        
//        [self.networkDicts removeObjectForKey:key];
//    }
//}

- (void)backPreviousController
{
//    [HUDManager hiddenHUD];
//    [iToast hiddenIToast];
    
    [self.view endEditing:YES];
    
    // 取消网络请求
//    [self releaseNet];
    
    if ([self isRootController])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.sy_navigationController popViewControllerAnimated:YES];
    }
    
    // end
}

#pragma mark - 视图

#pragma mark - 响应


#pragma mark - 代理

#pragma mark - 网络

#pragma mark - setter/getter

#pragma mark setter

#pragma mark getter


@end
