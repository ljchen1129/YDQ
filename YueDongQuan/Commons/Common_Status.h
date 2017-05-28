//
//  Common_Status.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/5/13.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  各状态信息与图标

#ifndef Common_Status_h
#define Common_Status_h

/********************** message ****************************/

#pragma mark 网络状态提示语

static NSString *const kStatusTitleSuccessExceed   = @"主人，钱都已经入袋了";
static NSString *const kStatusTitleEmptyStock      = @"暂无数据";
static NSString *const kStatusTitleEmptyMessage    = @"暂无消息";
static NSString *const kStatusTitleFailue          = @"查不到相关数据";
static NSString *const kStatusTitleWithoutNetwork  = @"没有网络";

#pragma mark 网络状态提示图标

#define kStatusImageSuccessExceed     kImageWithName(@"status_SuccessExceed")
#define kStatusImageEmptyStock        kImageWithName(@"status_EmptyStock")
#define kStatusImageEmptyMessage      kImageWithName(@"status_EmptyMessage")
#define kStatusImageEmptyAccount      kImageWithName(@"status_EmptyAccount")
#define kStatusImageFailue            kImageWithName(@"status_Empty")
#define kStatusImageWithoutNetwork    kImageWithName(@"status_ErrorNetwork")

/********************** message ****************************/

#endif /* Common_Status_h */
