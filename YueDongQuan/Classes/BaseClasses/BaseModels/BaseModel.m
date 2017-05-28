//
//  BaseModel.m
//
//  QQ:275080225
//  Created by wen jun on 12-10-13.
//  Copyright (c) 2013年 Wen Jun. All rights reserved.
//


#import "BaseModel.h"
#import "SYNetworkEnvironment.h"

static NSString *const DBName = @"VSSUPPORTSQLite";

@implementation BaseModel

#pragma mark - 缓存

////////////////////////////////////////////////////////////////////////////////////////

/**
 *  缓存数量据保存
 *
 *  @param complete 保存状态回调
 */
- (void)save:(void (^)(BOOL isSuccess))complete
{
    [[SYFMDBManager shareFMDB] saveDataWithData:self complete:^(BOOL isSuccess) {
        if (complete)
        {
            complete(isSuccess);
        }
    }];
}

/**
 *  缓存数据更新
 *
 *  @param complete 更新状态回调
 */
- (void)update:(void (^)(BOOL isSuccess))complete
{
    [[SYFMDBManager shareFMDB] updateDataWithData:self complete:^(BOOL isSuccess) {
        if (complete)
        {
            complete(isSuccess);
        }
    }];
}

/**
 *  缓存数据删除
 *
 *  @param complete 删除状态回调
 */
- (void)delete:(void (^)(BOOL isSuccess))complete
{
    [[SYFMDBManager shareFMDB] deleteDataWithData:self complete:^(BOOL isSuccess) {
        if (complete)
        {
            complete(isSuccess);
        }
    }];
}

/**
 *  缓存数据查找
 *
 *  @param complete 查找结果回调
 */
+ (void)searchComplete:(void (^)(NSArray *results))complete
{
    NSArray *array = [[SYFMDBManager shareFMDB] getAllDataWithClass:[self class]];
    if (complete)
    {
        complete(array);
    }
}

////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 数据model类型转换

/**
 *  返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)modelCustomPropertyMapper
{
    /*
    // 示例
    NSDictionary *dict = @{@"rs" : @[@"attributes.rs",@"attributes.vo"]};
    
    return dict;
     
    */
    
    return nil;
}

/**
 *  返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    /*
     // 示例（自定义model中的属性valueList为NSArray类型的，[ValueModel class]为valueList中的元素类型model）
     
     @interface AttributeModel : BaseIceModel
     
     @property (nonatomic, strong) NSString *attrName;
     @property (nonatomic, strong) NSArray *valueList;
     @property (nonatomic, strong) NSNumber *shopAttrKeyId;
     
     @end
     
     @interface ValueModel : BaseIceModel
     
     @property (nonatomic, strong) NSString *valueName;
     @property (nonatomic, strong) NSNumber *shopAttrValueId;
     
     @end
     
     */
    
    /*
     NSDictionary *dict = @{@"valueList" : [ValueModel class]};
     
     return dict;
     */
    
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////

/**
 *  将dict参数集转换成json字符串
 *
 *  @param ParamsDict NSDictionary参数集合
 *
 *  @return NSString  NSDictionary参数集合转换后的json字符串
 */
+ (NSString *)JSONStringWithDict:(NSDictionary *)ParamsDict
{
    if ([ParamsDict isKindOfClass:[NSDictionary class]] && ParamsDict && 0 != ParamsDict.count)
    {
        NSString *paraString = [NSString jsonStringWithDictionary:ParamsDict];
        return paraString;
    }
    
    return nil;
}

/**
 *  将json字符串转换成model
 *
 *  @param JSONString json字符串
 *  @param ModelClass model数据实体类型
 *
 *  @return id        json字符解析后返回的model实体
 */
+ (id)modelWithJSONString:(NSString *)JSONString model:(Class)ModelClass
{
    if ([JSONString isKindOfClass:[NSString class]] && JSONString && 0 != JSONString.length)
    {
        NSDictionary *resultDict = [NSString jsonDictWithString:JSONString];
        BaseModel *iceModel = [BaseModel yy_modelWithJSON:resultDict];
        
        id jsonObject = iceModel.rs;
        jsonObject = [[self class] modelWithModelClass:ModelClass object:jsonObject];
        iceModel.rs = jsonObject;
        
        return iceModel;
    }
    
    return nil;
}

// 返回对应类型的数据模型（返回数组model，或字典model，或其他）
+ (id)modelWithModelClass:(Class)modelClass object:(id)JSONObject
{
    if ([JSONObject isKindOfClass:[NSArray class]])
    {
        NSArray *result = [NSArray yy_modelArrayWithClass:modelClass json:JSONObject];
        return result;
    }
    else if ([JSONObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *result = [modelClass yy_modelWithDictionary:JSONObject];
        return result;
    }
  
    return JSONObject;
}

////////////////////////////////////////////////////////////////////////////////////////

/// 请求接口API
NSString *RequestServiceHostAppendingUrl(NSString *url)
{
    // add 添加版本号识别 张绍裕 20161214
//    NSString *version = [NSString stringWithFormat:@"ecsapp_v%@/", GetAppCurrentVersion];
//    NSMutableString *hostUrlTmp = [NSMutableString stringWithString:networkHost];
//    NSString *hostUrl = [hostUrlTmp stringByReplacingOccurrencesOfString:@"ecsapp/" withString:version];
    NSString *hostUrl = NetworkRequestHost;
    
    NSString *result = [NSString stringWithFormat:@"%@%@", hostUrl, ([NSString isValidNSString:url] ? url : @"")];
    
    return result;
}

/// 初始化API服务器接口
+ (void)initialize
{
    // 初始化
    [NetworkManager startWithServiceHost:NetworkRequestHost];
    [NetworkManager shareNetwork].requestType = RequestContentTypeOther;
    [NetworkManager shareNetwork].responseType = RequestContentTypeJSON;
}

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
                                                complete:(void (^)(BaseModel *))complete
{
    NSURLSessionDataTask *dataTask = [self requestWithUrl:url paramtes:dict type:RequestHttpTypePOST modelClass:modelClass hudType:RequestHUDTypeDefault target:nil enableView:YES complete:complete];
    return dataTask;
}

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
                                    complete:(void (^)(BaseModel *))complete
{
    NSURLSessionDataTask *dataTask = [self requestWithUrl:url paramtes:dict type:RequestHttpTypePOST modelClass:modelClass hudType:RequestHUDTypeDefault target:target enableView:YES complete:complete];
    return dataTask;
}

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
                                    complete:(void (^)(BaseModel *))complete
{
    NSURLSessionDataTask *dataTask = [self requestWithUrl:url paramtes:dict type:RequestHttpTypePOST modelClass:modelClass hudType:hudType target:target enableView:isEnable complete:complete];
    return dataTask;
}


/**
 *  网络请求（GET）
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
                                   complete:(void (^)(BaseModel *))complete
{
    NSURLSessionDataTask *dataTask = [self requestWithUrl:url paramtes:dict type:RequestHttpTypeGET modelClass:modelClass hudType:hudType target:target enableView:isEnable complete:complete];
    return dataTask;
}

/**
 *  网络请求（区分POST、GET）——有效
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
                                    type:(RequestHttpType)httpType
                              modelClass:(Class)modelClass
                                 hudType:(RequestHUDType)hudType
                                  target:(id)target
                              enableView:(BOOL)isEnable
                                complete:(void (^)(BaseModel *baseModel))complete
{
    NSURLSessionDataTask *dataTask = [self requestWithUrl:url paramtes:dict modelClass:modelClass requestType:httpType requestContentType:RequestContentTypeOther responseContentType:ResponseContentTypeJSON hudType:hudType target:target enableView:isEnable uploadProgress:nil downloadProgress:nil complete:complete];
    
    return dataTask;
}


/**
 *  网络请求——有效
 *
 *  @param url          API接口url
 *  @param dict         API请求参数
 *  @param modelClass   Model类型
 *  @param methordType  API请求类型（POST、或GET）
 *  @param requestType  API请求数据样式（XML，或JSON，或其他；默认其他）
 *  @param responseType API响应数据样式（XML，或JSON，或其他；默认JSON）
 *  @param hudType      hudType类型
 *  @param target       响应方法的对象（用于添加作参数，便于后续操作，如取消请求）
 *  @param isEnable   当前视图控制器正在进行网络请求时，是否允许操作视图（target不为nil）
 *  @param upload       上传进度回调
 *  @param download     下载进度回调
 *  @param complete     请求结果回调
 *
 *  @return NSURLSessionDataTask（便于后续操作处理，如取消请求）
 */
+ (NSURLSessionDataTask *)requestWithUrl:(NSString *)url
                                paramtes:(NSDictionary *)dict
                              modelClass:(Class)modelClass
                             requestType:(RequestHttpType)methordType
                      requestContentType:(RequestContentType)requestType
                     responseContentType:(ResponseContentType)responseType
                                 hudType:(RequestHUDType)hudType
                                  target:(id)target
                              enableView:(BOOL)isEnable
                          uploadProgress:(void (^)(NSProgress *uploadProgress))upload
                        downloadProgress:(void (^)(NSProgress *downloadProgress))download
                                complete:(void (^)(BaseModel *baseModel))complete
{
    DLog(@"\nbaseURL = %@ \nurl = %@ \ndict = %@", [NetworkManager shareNetwork].manager.baseURL, url, dict);
    
    DLog(@"当前网络状态：%@", ([NetworkManager isReachable] ? @"可用" : @"不可用"));
    
    if (![NetworkManager isReachable])
    {
        if (complete)
        {
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.success = NO;
            baseModel.msg = kNetworkNotReachable;
            
            complete(baseModel);
        }
        
        return nil;
    }
    
    // 显示加载符
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[self class] showHudWithType:hudType];
    
    // 是否屏蔽当前视图控制器的视图交互-禁用
    if (target)
    {
        UIViewController *controller = (UIViewController *)target;
        controller.view.userInteractionEnabled = isEnable;
    }
    
    // 请求样式
    NSString *requestMethord = (RequestHttpTypePOST == methordType ? @"POST" : @"GET");
    // 请求参数
    NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [self ResetParamWithDict:requestDict withPath:nil];
    
    [[NetworkManager shareNetwork] setResponseType:responseType];
    [[NetworkManager shareNetwork] setRequestType:requestType];
    
    NSURLSessionDataTask *dataTask = [[NetworkManager shareNetwork] requestWithUrl:url parameters:requestDict parametersType:YES httpType:requestMethord uploadProgress:^(NSProgress *uploadProgress) {
        
        // 是否屏蔽当前视图控制器的视图交互-有效
        if (target)
        {
            UIViewController *controller = (UIViewController *)target;
            controller.view.userInteractionEnabled = YES;
        }
        
        if (upload)
        {
            upload(uploadProgress);
        }
    } downloadProgress:^(NSProgress *downloadProgress) {
        
        // 是否屏蔽当前视图控制器的视图交互-有效
        if (target)
        {
            UIViewController *controller = (UIViewController *)target;
            controller.view.userInteractionEnabled = YES;
        }
        
        if (download)
        {
            download(downloadProgress);
        }
    } complete:^(NSURLResponse *response, id responseObject, NSError *error) {
        DLog(@"\nresponseObject(class = %@) = %@", [responseObject class], responseObject);
        DLog(@"error = %@", error);
        // 隐藏加载符
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (RequestHUDTypeDefault != hudType)
        {
            [HUDManager hiddenHUD];
        }
        
        // 是否屏蔽当前视图控制器的视图交互-有效
        if (target)
        {
            UIViewController *controller = (UIViewController *)target;
            controller.view.userInteractionEnabled = YES;
        }
        
        NSString *responseString = nil;
        if ([responseObject isKindOfClass:[NSString class]])
        {
            responseString = [[NSString alloc] initWithString:responseObject];
        }
        else if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            responseString = [self JSONStringWithDict:responseObject];
        }
        else if ([responseObject isKindOfClass:[NSData class]])
        {
            responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        DLog(@"\nresponseString = %@", responseString);
        
        BaseModel *baseModel = [BaseModel modelWithJSONString:responseString model:modelClass];
        
        if (error)
        {
            baseModel = [[BaseModel alloc] init];
            baseModel.success = NO;
            baseModel.msg = error.localizedFailureReason;
        }
        
        if (complete)
        {
            complete(baseModel);
        }
    }];
    
    // 请求开始
    [dataTask resume];

    if (target && [target respondsToSelector:@selector(addNet:)])
    {
        [target performSelector:@selector(addNet:) withObject:dataTask];
    }
    
    return dataTask;
}


#pragma mark 网络请求-网络释放

#pragma mark - methord

+ (void)showHudWithType:(RequestHUDType)type
{
    switch (type)
    {
        case RequestHUDTypeDefault:
        {

        }
            break;
        case RequestHUDTypeHidden:
        {
            [HUDManager hiddenHUD];
        }
            break;
        case RequestHUDTypeLogining:
        {
            [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:NO afterDelay:kHUDTime enabled:YES message:kAccountLogining];
        }
            break;
        case RequestHUDTypeLoginingAndLockScreen:
        {
            [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:NO afterDelay:kHUDTime enabled:NO message:kAccountLogining];
        }
            break;
        case RequestHUDTypeLoading:
        {
            [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:NO afterDelay:kHUDTime enabled:YES message:kNetworkLoading];
        }
            break;
        case RequestHUDTypeLoadingAndLockScreen:
        {
            [HUDManager showHUD:MBProgressHUDModeIndeterminate hide:NO afterDelay:kHUDTime enabled:NO message:kNetworkLoading];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 参数重定义

/// 重置请求参数
+ (void)ResetParamWithDict:(NSMutableDictionary *)dict withPath:(NSString *)path
{
    // 需要MD5（32位大写）加密的字段
    NSSet *const EncryptWithMD5 = [NSSet setWithObjects:@"password", nil];
    NSArray *allKeys = dict.allKeys;
    for (NSString *key in allKeys)
    {
        if ([EncryptWithMD5 containsObject:key])
        {
            NSString *oldObject = [dict objectForKey:key];
            if (oldObject)
            {
                if ([oldObject isKindOfClass:[NSNumber class]])
                {
                    oldObject = [NSString stringWithFormat:@"%@",oldObject];
                }
                
                NSString *MD5Str = [MD5Encryption getMd5WithText:oldObject bit32:YES uppercase:YES];
                [dict setValue:MD5Str forKey:key];
            }
        }
    }
}


////////////////////////////////////////////////////////////////////////////////////////

@end
