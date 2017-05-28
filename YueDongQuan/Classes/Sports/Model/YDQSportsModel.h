//
//  YDQSportsModel.h
//  YueDongQuan
//
//  Created by 陈良静 on 2017/5/22.
//  Copyright © 2017年 陈良静. All rights reserved.
//

#import "BaseModel.h"

@interface YDQSportsModel : BaseModel

+ (void)requsetSportsDataWithParams:(NSDictionary *)params target:(id)target complete:(void (^)(BaseModel *baseModel))complete;

@end
