//
//  Common_define.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用宏定义

#import "AppDelegate.h"

// 常用宏定义
#import "Common_font.h"
#import "Common_color.h"
#import "Common_Markwords.h"
#import "Common_time.h"
#import "Common_limit.h"
#import "Common_Status.h"
#import "AutoSizeCGRect.h"

//// 功能类扩展
#import "UIView+CLJExtension.h"
#import "UIBarButtonItem+CLJExtension.h"
#import "UIImage+CLJExtension.h"

// 常用第三方工具类
#import <FMDB/FMDB.h>
#import <Masonry/Masonry.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <YYModel/YYModel.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJRefresh/MJRefresh.h>
#import <LKDBHelper/LKDBHelper.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <PNChart/PNChart.h>

// 常用工具类
#import "HUDManager.h"
#import "MD5Encryption.h"

// 常用公共类
#import "BaseModel.h"
#import "SYHelper.h"


#ifndef HKC_Common_define_h
#define HKC_Common_define_h


/********************** 跳转App操作 ****************************/

static NSString *const USERID = @"123456";
static NSString *const UrlRRC = @"RenRenChuangMember://";                    // 指定APP
static NSString *const UrlRRCRegister = @"RenRenChuangMember://RRCRegister"; // 指定APP视图

/********************** 常用App操作 ****************************/

/// 获取当前app delegate
#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// 打开浏览器
#define OpenUrlInExplorer(urlString) {NSURL *url = [[NSURL alloc] initWithString:urlString];if ([[UIApplication sharedApplication] canOpenURL:url]){[[UIApplication sharedApplication] openURL:url];}} // {NSURL *url = [[NSURL alloc] initWithString:urlString];[[UIApplication sharedApplication] openURL:url];}

/// 拨打电话（弹窗提示）
#define PhoneCall(numString) {NSURL *mobileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", numString]];[[UIApplication sharedApplication] openURL:mobileUrl];}

/// 拨打电话（无弹窗提示，直接拨打）
#define PhoneCallDirectly(numString) {NSURL *mobileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", numString]];[[UIApplication sharedApplication] openURL:mobileUrl];}

// url
#define URLWithString(str)  [NSURL URLWithString:str]

/********************** 常用宏 ****************************/

#pragma mark - 常用宏

/// 判断无网络情况
#define GetNetworkStatusNotReachable ([AFNetworkReachabilityManager sharedManager].isReachable)

/// 当前app版本号
#define GetAppCurrentVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

/// 当前app标识
#define GetAppIdentifier ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"])

/// 当前app名称
#define GetAppName ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"])

/// 当前app delegate
#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

#define kLocalizedString(key) NSLocalizedString(key, nil)

/// Height/Width
#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width
#define kScreenHeight       [UIScreen mainScreen].applicationFrame.size.height
#define kAllHeight          ([UIScreen mainScreen].applicationFrame.size.height + 20.0)
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)
#define kTabbarHeight       49
#define kSearchBarHeight    45
#define kStatusBarHeight    20
#define kNavigationHeight   44

/// 设备类型-模拟器（模拟器，或真机）
#define isSimulatorDevice ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformName"] isEqualToString:@"iphonesimulator"])

/// 设备类型-真机（模拟器，或真机）
#define isIphoneosDevice ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformName"] isEqualToString:@"iphoneos"])

/// System判断
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define ISiPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) // IOS6的系统
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7的系统
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) // IOS8的系统

#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight

/// Dlog
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

/// DataManager
#define GetDataManager [DataManager sharedManager]

/// DataManagerModel
#define GetDataUserModel [[DataManager sharedManager] userModel]

/// 数值转字符串
#define NSIntegerToNSString(intValue) ([NSString stringWithFormat:@"%d", intValue])

/// 数值转字符串
#define kIntToString(intValue) ([NSString stringWithFormat:@"%@", @(intValue)])
#define kNumberToString(NumberValue) ([NSString stringWithFormat:@"%@", NumberValue])
#define StrToInt(str) [str integerValue]
#define StrToDouble(str) [str doubleValue]
#define DoubleStringFormat(str) [NSString stringWithFormat:@"%.2f", [str doubleValue]]

/********************** 标识 ****************************/

#pragma mark - 标识

static CGFloat const IQKeyboardDistanceFromTextField = 10.0; // IQKeyboard与输入控件间距

static NSString *const kSSToolkitTestsServiceName = @"VSTSUPPORTUser"; // 用户帐户

static NSString *const kSeparatedMarkComma              = @","; // 分隔或拼接符号，逗号
static NSString *const kSeparatedMarkline               = @"|"; // 分隔或拼接符号，竖线
static NSString *const kSeparatedMarkSpace              = @" "; // 分隔或拼接符号，空格
static NSString *const kSeparatedMarkAdd                = @"+"; // 分隔或拼接符号，加号
static NSString *const kSeparatedMarkBracketSquareleft  = @"["; // 分隔或拼接符号，中括号左
static NSString *const kSeparatedMarkBracketSquareRight = @"]"; // 分隔或拼接符号，中括号右
static NSString *const kSeparatedMarkBracketRoundleft   = @"("; // 分隔或拼接符号，小括号左
static NSString *const kSeparatedMarkBracketRoundRight  = @")"; // 分隔或拼接符号，小括号右
static NSString *const kSeparatedMarkSemicolon          = @";"; // 分隔或拼接符号，分号
static NSString *const kSeparatedMarkUparrow            = @"^"; // 分隔或拼接符号，上箭头号
static NSString *const kSeparatedMarkColon              = @":"; // 分隔或拼接符号，冒号

static NSString *const kMoneyCN = @"￥";  // 人民币标识符号

/// tabBar tintColor
#define YDQTabBarTintColor UIColorRGB(42,190,43)

/********************** 图片 ****************************/

#pragma mark - 图片
// 图片
#define ImageWithName(name) [UIImage imageNamed:name]

/// 图片，根据颜色设置
#define kImageWithColor(color) [UIImage imageWithColor:color size:CGSizeMake(1.0, 1.0)]

/// 获取图片，根据图片名称
#define kImageWithName(text) [UIImage imageNamed:text]

/// 获取图片，根据图片url
#define kImageWithURL(text) [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:URLWithString(imageUrl)]]

/// 拉伸图片边框处理
#define kImageUIEdgeWithName(text) [[UIImage imageNamed:text] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

/// 拉伸图片边框处理
#define kImageWithUIEdge(text, UIEdgeInsets) [[UIImage imageNamed:text] resizableImageWithCapInsets:UIEdgeInsets resizingMode:UIImageResizingModeStretch]

/// 没有加载图片显示的图片
#define kpage_image_loading @"default_businesses_photo"

/// cell透明背景色
#define kImage_cellClear [[UIImage imageWithColor:kColorClear size:CGSizeMake(1.0, 1.0)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 60, 0, 80) resizingMode:UIImageResizingModeStretch]

/// cell未选择时背景色
#define kImage_cellNormal [[UIImage imageWithColor:kColorWhite size:CGSizeMake(1.0, 1.0)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 60, 0, 80) resizingMode:UIImageResizingModeStretch]

/// cell选择时背景色
#define kImage_cellSelected [[UIImage imageWithColor:UIColorHex(0xfcf8cd) size:CGSizeMake(1.0, 1.0)] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 60, 0, 80) resizingMode:UIImageResizingModeStretch]

/// 默认图标，网络加载时
#define kImageDefaultIcon kImageWithName(@"icon_default")

/// 默认图标，网络加载时
#define kImageDefaultADIcon kImageWithName(@"AD_default")

/********************** ****************************/

// 手机号的框 四种情况组合输入框和cell的背景
#define kImage_LTSB [[UIImage imageNamed:@"longTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTLB [[UIImage imageNamed:@"longTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB [[UIImage imageNamed:@"noTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTLB [[UIImage imageNamed:@"noTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTSB2 [[UIImage imageNamed:@"longTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 70, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB2 [[UIImage imageNamed:@"noTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 2, 0) resizingMode:UIImageResizingModeStretch]


// 通用橙色确认按钮
// 按钮
#define kCommon_bt_normal    @"common_bt_normal"
#define kCommon_bt_touchDown @"common_bt_touchDown"
#define kCommon_bt_disable   @"common_bt_disable"

#define kImg_Common_bt_normal [[UIImage imageNamed:kCommon_bt_normal] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define kImg_Common_bt_touchDown [[UIImage imageNamed:kCommon_bt_touchDown] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define kImg_Common_bt_disable [[UIImage imageNamed:kCommon_bt_disable] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

/// 按钮透明颜色
#define kColorButtonNormal kImageWithColor(kColorClear)
/// 按钮点击颜色
#define kColorButtonHighlight kImageWithColor(UIColorHex_Alpha(0x000000, 0.3))

/********************** GCD ****************************/

#pragma mark - GCD

#define GCDBackComplete(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDMainComplete(block) dispatch_async(dispatch_get_main_queue(),block)

/********************** GCD ****************************/

#endif


