//
//  NSURLConnection+SYHelper.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 16/4/22.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "NSURLConnection+SYHelper.h"

typedef void (^ProgressBlock)(NSInteger connectionProgress);
typedef void (^DataBlock)(NSData *data);
typedef void (^SuccessBlock)(NSHTTPURLResponse *HTTPResponse);
typedef void (^FailureBlock)(NSError *error);

static ProgressBlock progressblock;
static DataBlock datablock;
static SuccessBlock successblock;
static FailureBlock failureblock;

@implementation NSURLConnection (SYHelper)

/// 异步请求（请求、进度、接收数据、成功、失败）
+ (NSURLConnection *)sendAsynchronousRequest:(NSURLRequest *)request
                           didUpdateProgress:(void (^)(NSInteger progress))progress
                              didReceiveData:(void (^)(NSData *data))data
                          didReceiveResponse:(void (^)(NSHTTPURLResponse *HTTPResponse))success
                            didFailWithError:(void (^)(NSError *error))fail
{
    progressblock = [progress copy];
    datablock = [data copy];
    successblock = [success copy];
    failureblock = [fail copy];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
    return connection;
}

#pragma mark - NSURLConnectionDelegate, NSURLConnectionDataDelegate

+ (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
    
    if (successblock)
    {
        successblock(HTTPResponse);
    }
}

+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (datablock)
    {
        datablock(data);
    }
}

+ (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSInteger progress = (totalBytesWritten * 100) / totalBytesExpectedToWrite;
    
    if (progressblock)
    {
        progressblock(progress);
    }
}

+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (failureblock)
    {
        failureblock(error);
    }
}

@end
