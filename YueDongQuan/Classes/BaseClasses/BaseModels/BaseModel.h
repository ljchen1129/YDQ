//
//  BaseModel.h
//
//  QQ:275080225
//  Created by wen jun on 12-10-13.
//  Copyright (c) 2013年 Wen Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <LKDBHelper/LKDBHelper.h>
#import "NetworkManager.h"
#import "SYNetworkCache.h"
#import "SYNetworkEnvironment.h"

/// 加载成功
static NSInteger const kFlagSuccess = 1;
/// 加载失败
static NSInteger const kFlagFailure = 0;
/// 第一页
static NSInteger const kPageFirst = 1;
/// 分页大小（即每页数量）
static NSInteger const kPageSize = 5;


/// 请求样式（post，或get）
typedef NS_ENUM(NSInteger, RequestHttpType)
{
    /// 请求样式-post
    RequestHttpTypePOST = 1,
    
    /// 请求样式-get
    RequestHttpTypeGET = 2,
};


/// HUD样式（不显示，显示不锁屏，或显示锁屏）
typedef NS_ENUM(NSInteger, RequestHUDType)
{
    /// HUD样式-不做处理
    RequestHUDTypeDefault = 0,
    
    /// HUD样式-不显示
    RequestHUDTypeHidden = 1,
    
    /// HUD样式-显示登录中且不锁屏
    RequestHUDTypeLogining = 2,
    
    /// HUD样式-显示登录中且锁屏
    RequestHUDTypeLoginingAndLockScreen = 3,
    
    /// HUD样式-显示加载中且不锁屏
    RequestHUDTypeLoading = 4,
    
    /// HUD样式-显示加载中且锁屏
    RequestHUDTypeLoadingAndLockScreen = 5
};

/// NSMutableDictionary，用于设置网络请求参数
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) {if (obj) {[ParamsDic setObject:obj forKey:key];}}
#define DicValueSet(value,key) {if (value) {[ParamsDic setObject:value forKey:key];}}


/// 假数据
#define FalseData(jsonString) complete(([self modelWithJSONString:jsonString model:[self class]]))


///********************** app环境 ****************************/

/*
#pragma mark - app环境

#define isTrueEnvironment 0

#if isTrueEnvironment

/// 真实环境
#define kServerHost         @"http://192.168.3.165:8080/ecsapp/"
//#define kServerResourceHost @"http://hkdmobile.365sji.com/restservice"
//#define kServerHtml         @"http://hkdmobile.365sji.com/restservice/noticeDetail.jsp?noticeId=%@"

#else

/// 测试环境
#define kServerHost         @"http://192.168.3.165:8080/ecsapp/"
//#define kServerHost         @"192.168.17.237:8080/rrcpro-api" // 杨俊
//#define kServerResourceHost @"http://qichedai.365sji.com:8027/restservice"
//#define kServerHtml         @"http://qichedai.365sji.com:8027/restservice/noticeDetail.jsp?noticeId=%@"

/// 预生产环境
// http://192.168.16.219:8183/rrcpro-api

#endif
*/

///********************** app环境 ****************************/

@interface BaseModel : NSObject

#pragma mark - 缓存

////////////////////////////////////////////////////////////////////////////////////////

/**
 *  缓存数量据保存
 *
 *  @param complete 保存状态回调
 */
- (void)save:(void (^)(BOOL isSuccess))complete;

/**
 *  缓存数据更新
 *
 *  @param complete 更新状态回调
 */
- (void)update:(void (^)(BOOL isSuccess))complete;

/**
 *  缓存数据删除
 *
 *  @param complete 删除状态回调
 */
- (void)delete:(void (^)(BOOL isSuccess))complete;

/**
 *  缓存数据查找
 *
 *  @param complete 查找结果回调
 */
+ (void)searchComplete:(void (^)(NSArray *results))complete;

////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 基类数据model

/// 接口返回提示信息
@property (nonatomic, strong) NSString *msg;
/// 接口返回成功或失败标识
@property (nonatomic, assign) BOOL success;
/// 接口返回内容
//@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) id rs;

/// 接口返回当前页数
@property (nonatomic, assign) int currentPage;
/// 接口返回总共的页数
@property (nonatomic, assign) int totalPage;

/// 接口返回状态码
@property (nonatomic, assign) int code;
/// 接口返回总共的个数
@property (nonatomic, assign) int totalSize;


////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 数据model类型转换

/**
 *  返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)modelContainerPropertyGenericClass;

////////////////////////////////////////////////////////////////////////////////////////

/**
 *  将dict参数集转换成json字符串
 *
 *  @param ParamsDict NSDictionary参数集合
 *
 *  @return NSString  NSDictionary参数集合转换后的json字符串
 */
+ (NSString *)JSONStringWithDict:(NSDictionary *)ParamsDict;

/**
 *  将json字符串转换成model
 *
 *  @param JSONString json字符串
 *  @param ModelClass model数据实体类型
 *
 *  @return id        json字符解析后返回的model实体
 */
+ (id)modelWithJSONString:(NSString *)JSONString model:(Class)ModelClass;

////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 数据网络请求

/// 请求接口API
NSString *RequestServiceHostAppendingUrl(NSString *url);

#pragma mark - 网络请求-数据网络请求

/**
 *  网络请求（后台POST）——有效
 *
 *  @param url        API接口url
 *  @param dict       API请求参数
 *  @param modelClass Model类型
 *  @param complete   请求结果回调
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
+ (NSURLSessionDataTask *)requestInBackgroundPOSTWithUrl:(NSString *)url
                                                paramtes:(NSDictionary *)dict
                                              modelClass:(Class)modelClass
                                                complete:(void (^)(BaseModel *))complete;

/**
 *  网络请求（POST）——有效
 *
 *  @param url        API接口url
 *  @param dict       API请求参数
 *  @param modelClass Model类型
 *  @param target     响应方法的对象（用于添加作参数，便于后续操作，如取消请求）
 *  @param complete   请求结果回调
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
+ (NSURLSessionDataTask *)requestPOSTWithUrl:(NSString *)url
                                    paramtes:(NSDictionary *)dict
                                  modelClass:(Class)modelClass
                                      target:(id)target
                                    complete:(void (^)(BaseModel *))complete;

/**
 *  网络请求（POST）——有效
 *
 *  @param url        API接口url
 *  @param dict       API请求参数
 *  @param modelClass Model类型
 *  @param hudType    hudType类型
 *  @param target     响应方法的对象（用于添加作参数，便于后续操作，如取消请求）
 *  @param isEnable   当前视图控制器正在进行网络请求时，是否允许操作视图（target不为nil）
 *  @param complete   请求结果回调
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
+ (NSURLSessionDataTask *)requestPOSTWithUrl:(NSString *)url
                                    paramtes:(NSDictionary *)dict
                                  modelClass:(Class)modelClass
                                     hudType:(RequestHUDType)hudType
                                      target:(id)target
                                  enableView:(BOOL)isEnable
                                    complete:(void (^)(BaseModel *))complete;


/**
 *  网络请求（GET）——有效
 *
 *  @param url        API接口url
 *  @param dict       API请求参数
 *  @param modelClass Model类型
 *  @param hudType    hudType类型
 *  @param target     响应方法的对象（用于添加作参数，便于后续操作，如取消请求）
 *  @param isEnable   当前视图控制器正在进行网络请求时，是否允许操作视图（target不为nil）
 *  @param complete   请求结果回调
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
+ (NSURLSessionDataTask *)requestGETWithUrl:(NSString *)url
                                   paramtes:(NSDictionary *)dict
                                 modelClass:(Class)modelClass
                                    hudType:(RequestHUDType)hudType
                                     target:(id)target
                                 enableView:(BOOL)isEnable
                                   complete:(void (^)(BaseModel *))complete;


/**
 *  网络请求——有效
 *
 *  @param url        API接口url
 *  @param dict       API请求参数
 *  @param type       API请求类型（POST、或GET）
 *  @param modelClass Model类型
 *  @param hudType    hudType类型
 *  @param target     响应方法的对象（用于添加作参数，便于后续操作，如取消请求）
 *  @param isEnable   当前视图控制器正在进行网络请求时，是否允许操作视图（target不为nil）
 *  @param complete   请求结果回调
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
+ (NSURLSessionDataTask *)requestWithUrl:(NSString *)url
                                paramtes:(NSDictionary *)dict
                                    type:(RequestHttpType)type
                              modelClass:(Class)modelClass
                                 hudType:(RequestHUDType)hudType
                                  target:(id)target
                              enableView:(BOOL)isEnable
                                complete:(void (^)(BaseModel *baseModel))complete;


#pragma mark - 网络请求-网络释放

////////////////////////////////////////////////////////////////////////////////////////



@end
