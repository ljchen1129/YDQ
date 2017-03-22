//
//  SYNavigationController.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/12/13.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "SYNavigationController.h"
#import <objc/runtime.h>
#import "UIViewController+SYNavigationController.h"

/******************************************************************************/

@interface NSArray<ObjectType> (SYNavigationController)

- (NSArray *)returnArrays_map:(id(^)(ObjectType obj, NSUInteger index))block;
- (BOOL)returnArrays_any:(BOOL(^)(ObjectType obj))block;

@end

@implementation NSArray (SYNavigationController)

- (NSArray *)returnArrays_map:(id (^)(id object, NSUInteger index))block
{
    if (!block)
    {
        block = ^(id object, NSUInteger index)
        {
            return object;
        };
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        [array addObject:block(object, index)];
    }];
    return [NSArray arrayWithArray:array];
}

- (BOOL)returnArrays_any:(BOOL (^)(id))block
{
    if (!block)
    {
        return NO;
    }
    
    __block BOOL result = NO;
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if (block(object))
        {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end

/******************************************************************************/

#pragma mark - 内容视图控制器

@interface SYContainerController ()

@property (nonatomic, strong) __kindof UIViewController *contentViewController;
@property (nonatomic, strong) UINavigationController *containerNavigationController;

+ (instancetype)containerControllerWithController:(UIViewController *)controller;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo;
+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
                                backBarButtonItem:(UIBarButtonItem *)backItem
                                        backTitle:(NSString *)backTitle;

- (instancetype)initWithController:(UIViewController *)controller;
- (instancetype)initWithController:(UIViewController *)controller navigationBarClass:(Class)navigationBarClass;

@end

static inline UIViewController *SYSafeUnwrapViewController(UIViewController *controller)
{
    if ([controller isKindOfClass:[SYContainerController class]])
    {
        return ((SYContainerController *)controller).contentViewController;
    }
    return controller;
}

__attribute((overloadable)) static inline UIViewController *SYSafeWrapViewController(UIViewController *controller, Class navigationBarClass, BOOL withPlaceholder, UIBarButtonItem *backItem, NSString *backTitle)
{
    if (![controller isKindOfClass:[SYContainerController class]])
    {
        return [SYContainerController containerControllerWithController:controller
                                                     navigationBarClass:navigationBarClass
                                              withPlaceholderController:withPlaceholder
                                                      backBarButtonItem:backItem
                                                              backTitle:backTitle];
    }
    return controller;
}

__attribute((overloadable)) static inline UIViewController *SYSafeWrapViewController(UIViewController *controller, Class navigationBarClass, BOOL withPlaceholder)
{
    if (![controller isKindOfClass:[SYContainerController class]])
    {
        return [SYContainerController containerControllerWithController:controller
                                                     navigationBarClass:navigationBarClass
                                              withPlaceholderController:withPlaceholder];
    }
    return controller;
}

__attribute((overloadable)) static inline UIViewController *SYSafeWrapViewController(UIViewController *controller, Class navigationBarClass)
{
    return SYSafeWrapViewController(controller, navigationBarClass, NO);
}


@implementation SYContainerController

+ (instancetype)containerControllerWithController:(UIViewController *)controller
{
    return [[self alloc] initWithController:controller];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
{
    return [[self alloc] initWithController:controller navigationBarClass:navigationBarClass];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
{
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass
                  withPlaceholderController:yesOrNo];
}

+ (instancetype)containerControllerWithController:(UIViewController *)controller
                               navigationBarClass:(Class)navigationBarClass
                        withPlaceholderController:(BOOL)yesOrNo
                                backBarButtonItem:(UIBarButtonItem *)backItem
                                        backTitle:(NSString *)backTitle
{
    return [[self alloc] initWithController:controller
                         navigationBarClass:navigationBarClass
                  withPlaceholderController:yesOrNo
                          backBarButtonItem:backItem
                                  backTitle:backTitle];
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
         withPlaceholderController:(BOOL)yesOrNo
                 backBarButtonItem:(UIBarButtonItem *)backItem
                         backTitle:(NSString *)backTitle
{
    self = [super init];
    if (self)
    {
        // not work while push to a hideBottomBar view controller, give up
        /*
         self.edgesForExtendedLayout = UIRectEdgeAll;
         self.extendedLayoutIncludesOpaqueBars = YES;
         self.automaticallyAdjustsScrollViewInsets = NO;
         */
        
        self.contentViewController = controller;
        self.containerNavigationController = [[SYContainerNavigationController alloc] initWithNavigationBarClass:navigationBarClass toolbarClass:nil];
        if (yesOrNo)
        {
            UIViewController *vc = [UIViewController new];
            vc.title = backTitle;
            vc.navigationItem.backBarButtonItem = backItem;
            self.containerNavigationController.viewControllers = @[vc, controller];
        }
        else
        {
            self.containerNavigationController.viewControllers = @[controller];
        }
        
        [self addChildViewController:self.containerNavigationController];
        [self.containerNavigationController didMoveToParentViewController:self];
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
         withPlaceholderController:(BOOL)yesOrNo
{
    return [self initWithController:controller
                 navigationBarClass:navigationBarClass
          withPlaceholderController:yesOrNo
                  backBarButtonItem:nil
                          backTitle:nil];
}

- (instancetype)initWithController:(UIViewController *)controller
                navigationBarClass:(Class)navigationBarClass
{
    return [self initWithController:controller
                 navigationBarClass:navigationBarClass
          withPlaceholderController:NO];
}

- (instancetype)initWithController:(UIViewController *)controller
{
    return [self initWithController:controller navigationBarClass:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerNavigationController.view.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:self.containerNavigationController.view];
    
    self.containerNavigationController.view.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.contentViewController preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden
{
    return [self.contentViewController prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return [self.contentViewController preferredStatusBarUpdateAnimation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.contentViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    return self.contentViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.contentViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.contentViewController.preferredInterfaceOrientationForPresentation;
}

- (nullable UIView *)rotatingHeaderView
{
    return self.contentViewController.rotatingHeaderView;
}

- (nullable UIView *)rotatingFooterView
{
    return self.contentViewController.rotatingFooterView;
}


- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    return [self.contentViewController viewControllerForUnwindSegueAction:action
                                                       fromViewController:fromViewController
                                                               withSender:sender];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return self.contentViewController.hidesBottomBarWhenPushed;
}

- (NSString *)title
{
    return self.contentViewController.title;
}

- (UITabBarItem *)tabBarItem
{
    return self.contentViewController.tabBarItem;
}

@end

/******************************************************************************/

#pragma mark - 内容导航视图控制器

@interface UIViewController (SYContainerNavigationController)

@property (nonatomic, assign, readonly) BOOL sy_hasSetInteractivePop;

@end

@implementation UIViewController (SYContainerNavigationController)

- (BOOL)sy_hasSetInteractivePop
{
    return !!objc_getAssociatedObject(self, @selector(sy_disableInteractivePop));
}

@end


@implementation SYContainerNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:rootViewController.sy_navigationBarClass
                                toolbarClass:nil];
    if (self)
    {
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.interactivePopGestureRecognizer.delegate = nil;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    if (self.sy_navigationController.transferNavigationBarAttributes)
    {
        self.navigationBar.translucent = self.navigationController.navigationBar.isTranslucent;
        self.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        self.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        self.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
        self.navigationBar.backgroundColor = self.navigationController.navigationBar.backgroundColor;
        
        UIImage *backImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
        CGFloat positionAdjustment = [self.navigationController.navigationBar titleVerticalPositionAdjustmentForBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setTitleVerticalPositionAdjustment:positionAdjustment forBarMetrics:UIBarMetricsDefault];
        
        self.navigationBar.titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
        self.navigationBar.shadowImage = self.navigationController.navigationBar.shadowImage;
        self.navigationBar.backIndicatorImage = self.navigationController.navigationBar.backIndicatorImage;
        self.navigationBar.backIndicatorTransitionMaskImage = self.navigationController.navigationBar.backIndicatorTransitionMaskImage;
    }
    [self.view layoutIfNeeded];
}

- (UITabBarController *)tabBarController
{
    UITabBarController *tabController = [super tabBarController];
    SYNavigationController *navigationController = self.sy_navigationController;
    if (tabController)
    {
        if (navigationController.tabBarController != tabController)
        {
            // Tab is child of Root VC
            return tabController;
        }
        else
        {
            BOOL isTranslucent = tabController.tabBar.isTranslucent;
            return !isTranslucent || [navigationController.sy_viewControllers returnArrays_any:^BOOL(__kindof UIViewController *obj) {
                return obj.hidesBottomBarWhenPushed;
            }] ? nil : tabController;
        }
    }
    return nil;
}

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    if (self.navigationController)
    {
        return [self.navigationController viewControllerForUnwindSegueAction:action
                                                          fromViewController:self.parentViewController
                                                                  withSender:sender];
    }
    return [super viewControllerForUnwindSegueAction:action
                                  fromViewController:fromViewController
                                          withSender:sender];
}

- (NSArray<UIViewController *> *)allowedChildViewControllersForUnwindingFromSource:(UIStoryboardUnwindSegueSource *)source
{
    if (self.navigationController)
    {
        return [self.navigationController allowedChildViewControllersForUnwindingFromSource:source];
    }
    return [super allowedChildViewControllersForUnwindingFromSource:source];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if (self.navigationController)
    {
        [self.navigationController pushViewController:viewController
                                             animated:animated];
    }
    else
    {
        [super pushViewController:viewController
                         animated:animated];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.navigationController respondsToSelector:aSelector])
    {
        return self.navigationController;
    }
    return nil;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.navigationController)
    {
        return [self.navigationController popViewControllerAnimated:animated];
    }
    return [super popViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.navigationController)
    {
        return [self.navigationController popToRootViewControllerAnimated:animated];
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                     animated:(BOOL)animated
{
    if (self.navigationController)
    {
        return [self.navigationController popToViewController:viewController animated:animated];
    }
    return [super popToViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated
{
    if (self.navigationController)
    {
        [self.navigationController setViewControllers:viewControllers animated:animated];
    }
    else
    {
        [super setViewControllers:viewControllers animated:animated];
    }
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    if (self.navigationController)
    {
        self.navigationController.delegate = delegate;
    }
    else
    {
        [super setDelegate:delegate];
    }
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    [super setNavigationBarHidden:hidden animated:animated];
    if (!self.visibleViewController.sy_hasSetInteractivePop)
    {
        self.visibleViewController.sy_disableInteractivePop = hidden;
    }
}

@end

/******************************************************************************/

#pragma mark - 导航视图控制器

@interface SYNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<UINavigationControllerDelegate> syDelegate;
@property (nonatomic, copy) void(^animationBlock)(BOOL finished);

@end

@implementation SYNavigationController

#pragma mark 响应事件


#pragma mark 实例化

- (void)awakeFromNib
{
    self.viewControllers = [super viewControllers];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {

    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self)
    {

    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:SYSafeWrapViewController(rootViewController, rootViewController.sy_navigationBarClass)];
    if (self)
    {

    }
    return self;
}

- (instancetype)initWithRootViewControllerNoWrapping:(UIViewController *)rootViewController
{
    self = [super init];
    if (self)
    {
        [super pushViewController:rootViewController animated:NO];
    }
    return self;
}

#pragma mark 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super setDelegate:self];
    [super setNavigationBarHidden:YES animated:NO];
}

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    UIViewController *controller = [super viewControllerForUnwindSegueAction:action
                                                          fromViewController:fromViewController
                                                                  withSender:sender];
    if (!controller)
    {
        NSInteger index = [self.viewControllers indexOfObject:fromViewController];
        if (index != NSNotFound)
        {
            for (NSInteger i = index - 1; i >= 0; --i)
            {
                controller = [self.viewControllers[i] viewControllerForUnwindSegueAction:action
                                                                      fromViewController:fromViewController
                                                                              withSender:sender];
                if (controller)
                {
                    break;
                }
            }
        }
    }
    return controller;
}

- (void)setNavigationBarHidden:(__unused BOOL)hidden animated:(__unused BOOL)animated
{
    // Override to protect
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        UIViewController *currentLast = SYSafeUnwrapViewController(self.viewControllers.lastObject);
        [super pushViewController:SYSafeWrapViewController(viewController,
                                                           viewController.sy_navigationBarClass,
                                                           self.showBackBarButtonItem,
                                                           currentLast.navigationItem.backBarButtonItem,
                                                           currentLast.title)
                         animated:animated];
    }
    else
    {
        [super pushViewController:SYSafeWrapViewController(viewController, viewController.sy_navigationBarClass)
                         animated:animated];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return SYSafeUnwrapViewController([super popViewControllerAnimated:animated]);
}

- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [[super popToRootViewControllerAnimated:animated] returnArrays_map:^id(__kindof UIViewController *obj, NSUInteger index) {
        return SYSafeUnwrapViewController(obj);
    }];
}

- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                     animated:(BOOL)animated
{
    __block UIViewController *controllerToPop = nil;
    [[super viewControllers] enumerateObjectsUsingBlock:^(__kindof UIViewController *obj, NSUInteger idx, BOOL *stop) {
        if (SYSafeUnwrapViewController(obj) == viewController)
        {
            controllerToPop = obj;
            *stop = YES;
        }
    }];
    if (controllerToPop)
    {
        return [[super popToViewController:controllerToPop animated:animated] returnArrays_map:^id(__kindof UIViewController *obj, __unused NSUInteger index) {
            return SYSafeUnwrapViewController(obj);
        }];
    }
    return nil;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers
                  animated:(BOOL)animated
{
    [super setViewControllers:[viewControllers returnArrays_map:^id(__kindof UIViewController *obj,  NSUInteger index) {
        if (self.showBackBarButtonItem && index > 0)
        {
            return SYSafeWrapViewController(obj,
                                            obj.sy_navigationBarClass,
                                            self.showBackBarButtonItem,
                                            viewControllers[index - 1].navigationItem.backBarButtonItem,
                                            viewControllers[index - 1].title);
        }
        else
        {
            return SYSafeWrapViewController(obj, obj.sy_navigationBarClass);
        }
    }]
                     animated:animated];
}

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    self.syDelegate = delegate;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (nullable UIView *)rotatingHeaderView
{
    return self.topViewController.rotatingHeaderView;
}

- (nullable UIView *)rotatingFooterView
{
    return self.topViewController.rotatingFooterView;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
    {
        return YES;
    }
    return (self.syDelegate && [self.syDelegate respondsToSelector:aSelector]);
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.syDelegate;
}

#pragma mark Public Methods

- (UIViewController *)sy_topViewController
{
    return SYSafeUnwrapViewController([super topViewController]);
}

- (UIViewController *)sy_visibleViewController
{
    return SYSafeUnwrapViewController([super visibleViewController]);
}

- (NSArray <__kindof UIViewController *> *)sy_viewControllers
{
    return [[super viewControllers] returnArrays_map:^id(id obj, __unused NSUInteger index) {
        return SYSafeUnwrapViewController(obj);
    }];
}

- (void)removeViewController:(UIViewController *)controller
{
    [self removeViewController:controller animated:NO];
}

- (void)removeViewController:(UIViewController *)controller animated:(BOOL)flag
{
    NSMutableArray<__kindof UIViewController *> *controllers = [self.viewControllers mutableCopy];
    __block UIViewController *controllerToRemove = nil;
    [controllers enumerateObjectsUsingBlock:^(__kindof UIViewController * obj, NSUInteger idx, BOOL * stop) {
        if (SYSafeUnwrapViewController(obj) == controller)
        {
            controllerToRemove = obj;
            *stop = YES;
        }
    }];
    if (controllerToRemove)
    {
        [controllers removeObject:controllerToRemove];
        [super setViewControllers:[NSArray arrayWithArray:controllers] animated:flag];
    }
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                  complete:(void (^)(BOOL))block
{
    if (self.animationBlock)
    {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    [self pushViewController:viewController animated:animated];
}

- (NSArray <__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController
                                                      animated:(BOOL)animated
                                                      complete:(void (^)(BOOL))block
{
    if (self.animationBlock)
    {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    NSArray <__kindof UIViewController *> *array = [self popToViewController:viewController animated:animated];
    if (!array.count)
    {
        if (self.animationBlock)
        {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
    }
    return array;
}

- (NSArray <__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
                                                                  complete:(void (^)(BOOL))block
{
    if (self.animationBlock)
    {
        self.animationBlock(NO);
    }
    self.animationBlock = block;
    
    NSArray <__kindof UIViewController *> *array = [self popToRootViewControllerAnimated:animated];
    if (!array.count)
    {
        if (self.animationBlock)
        {
            self.animationBlock(YES);
            self.animationBlock = nil;
        }
    }
    return array;
}

#pragma mark UINavigationController Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    if (!isRootVC)
    {
        viewController = SYSafeUnwrapViewController(viewController);
        if (!self.showBackBarButtonItem && !viewController.navigationItem.leftBarButtonItem)
        {
            viewController.navigationItem.leftBarButtonItem = [viewController barButtonItemWithTitle:@"返回" action:^(UIBarButtonItem *item) {
                [self popViewControllerAnimated:YES];
            }];
        }
    }
    else
    {
        viewController = SYSafeUnwrapViewController(viewController);
        if (self.showCancelBarButtonItem && !viewController.navigationItem.leftBarButtonItem)
        {
            viewController.navigationItem.leftBarButtonItem = [viewController barButtonItemWithTitle:@"取消" action:^(UIBarButtonItem *item) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }
    
    if (self.syDelegate && [self.syDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)])
    {
        [self.syDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    viewController = SYSafeUnwrapViewController(viewController);
    if (viewController.sy_disableInteractivePop)
    {
        self.interactivePopGestureRecognizer.delegate = nil;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    else
    {
        self.interactivePopGestureRecognizer.delaysTouchesBegan = YES;
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
    [SYNavigationController attemptRotationToDeviceOrientation];
    
    if (self.animationBlock)
    {
        self.animationBlock(YES);
        self.animationBlock = nil;
    }
    
    if (self.syDelegate && [self.syDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)])
    {
        [self.syDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    
    if (self.syDelegate && [self.syDelegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)])
    {
        return [self.syDelegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    
    if (self.syDelegate && [self.syDelegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)])
    {
        return [self.syDelegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationPortrait;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (self.syDelegate && [self.syDelegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)])
    {
        return [self.syDelegate navigationController:navigationController interactionControllerForAnimationController:animationController];
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (self.syDelegate && [self.syDelegate respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)])
    {
        return [self.syDelegate navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    }
    return nil;
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return (gestureRecognizer == self.interactivePopGestureRecognizer);
}



@end

/******************************************************************************/

