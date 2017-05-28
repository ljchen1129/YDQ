//
//  YDQSportsModel.m
//  YueDongQuan
//
//  Created by 陈良静 on 2017/5/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "YDQSportsModel.h"

@implementation YDQSportsModel

+ (void)requsetSportsDataWithParams:(NSDictionary *)params target:(id)target complete:(void (^)(BaseModel *baseModel))complete;
{
//    // 1.构造请求参数
//    CreateParamsDic;
   
    // 2.发送请求
    NSString *url = RequestServiceHostAppendingUrl(@"appReceivableModel/overdueFollow");
    
    [self requestPOSTWithUrl:@"https://api.51yund.com/yd_homepage/get_homepage_info_v2" paramtes:params modelClass:[self class] target:self complete:complete];
}

@end
