//
//  Common_Markwords.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 14-10-27.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//  功能描述：常用提示语

#ifndef zhangshaoyu_Common_Markwords_h
#define zhangshaoyu_Common_Markwords_h

/********************** message ****************************/

#pragma mark - 提示语

#pragma mark ActionSheep弹出视图提示语

static NSString *const ActionTitle                      = @"温馨提示";
static NSString *const ActionCancel                     = @"取消";
static NSString *const ActionConfirm                    = @"确定";
static NSString *const ActionTitleModifyHeaderImage     = @"修改头像";
static NSString *const ActionTakingPictures             = @"拍照";
static NSString *const ActionPhotoAlbum                 = @"从相册选择";

#pragma mark AlertView弹出视图提示语

static NSString *const AlertTitle              = @"温馨提示";
static NSString *const AlertTitleCheckVersion  = @"检测到新版本";
static NSString *const AlertTitleExit          = @"退出登录";
static NSString *const AlertCancel             = @"取消";
static NSString *const AlertExit               = @"退出";
static NSString *const AlertConfirm            = @"确认";
static NSString *const AlertRealized           = @"知道了";
static NSString *const AlertClose              = @"关闭";
static NSString *const AlertUpgrade            = @"去升级";
static NSString *const AlertUpDate             = @"立即更新";
static NSString *const AlertMeaageExit         = @"是否退出登录？";
static NSString *const AlertWithdraw           = @"提现";
static NSString *const AlertRecharge           = @"充值";
static NSString *const AlertNetworkTipsMessage = @"亲，您现在处于非WiFi环境，继续观看会产生流量费用";
static NSString *const AlertAlwaysWatch        = @"继续观看";
static NSString *const AlertCancelWatch        = @"取消观看";

#pragma mark 网络交互提示语

static NSString *const kNetworkNotReachable          = @"网络断了哦，请检查网络再试";
static NSString *const kNetworkWithoutInternet       = @"网络断了哦，请检查网络再试";
static NSString *const kNetworkWithoutData           = @"暂无数据";
static NSString *const kNetworkWithoutInvestmentData = @"暂无可投资项目";
static NSString *const kNetworkLoading               = @"加载中...";
static NSString *const kNetworkLoadFailed            = @"网络不给力喔，刷新试试吧";
static NSString *const kNetworkSaveFailed            = @"保存失败";
static NSString *const kNetworkWaitting              = @"请稍后...";
static NSString *const kNetworkStatisticing          = @"统计中...";

static NSString *const kAccountLogining        = @"登录中";
static NSString *const kAccountLoginSuccess    = @"登录成功";
static NSString *const kAccoutRegistering      = @"注册中...";
static NSString *const kAccountFindPW          = @"设置密码中...";
static NSString *const kAccountRegisterSuccsee = @"注册成功！";

static NSString *const kVeridateSending        = @"正在发送短信验证码...";
static NSString *const kVeridateChecking       = @"正在校验短信验证码...";

static NSString *const kAccountUserNameNull = @"请输入用户名";
static NSString *const kAccountpasswordNull = @"请输入密码";

#pragma mark 输入限制

static NSString *const kRegisterMobileNull          = @"请输入11位手机号";
static NSString *const kRegisterMobileWrong         = @"请输入正确的手机号";
static NSString *const kRegisterVerityNull          = @"请输入验证码";
static NSString *const kRegisterVerityWrong         = @"请输入正确的验证码";
static NSString *const kRegisterAccountNull         = @"请输入用户名";
static NSString *const kRegisterAccountNum          = @"请输入6-20位用户名";
static NSString *const kRegisterAccountRegex        = @"帐号格式错误，请重试"; // @"不允许纯数字用户名"
static NSString *const kRegisterPasswordNull        = @"请输入密码";
static NSString *const kRegisterPasswordNum         = @"请输入6-20位密码";
static NSString *const kRegisterPasswordConfrimNull = @"请输入确认密码";
static NSString *const kRegisterPasswordConfirmNum  = @"请输入6-20位确认密码";
static NSString *const kRegisterPasswordNoSame      = @"密码输入不一致，请重新输入";
static NSString *const kRegisterPasswordOld         = @"请输入原密码";
static NSString *const kRegisterPasswordNew         = @"请输入6-20位新密码";
static NSString *const kPayPasswordNum              = @"请输入6位支付密码";

#pragma mark 定位

static NSString *const kAreaDefault      = @"选择省/市/区";
static NSString *const klocationFailed   = @"定位失败...";
static NSString *const klocationStart    = @"正在定位...";
static NSString *const kSearchRoadFailed = @"寻路失败";
static NSString *const kSearchRoadStart  = @"寻路中...";

/********************** message ****************************/

#endif
