//
//  BaseNetManager.m
//  BaseProject
//
//  Created by luzhe on 15/10/21.
//  Copyright © 2015年 luzhe. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPSessionManager *manager = nil;
static dispatch_source_t timer;
@implementation BaseNetManager
+  (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html", @"application/json",  @"text/javascript", @"text/plain", nil];
    });
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json", @"text/javascript",@"text/plain", nil];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-access-id"];
//    [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-signature"];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setTimeoutInterval:10];
    return manager;
}
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *percentPath =[NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;

    for (int i = 0; i < count; i++) {
        if (i == 0)
        {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else
        {
            [percentPath appendFormat:@",%@=%@", keys[i], params[keys[i]]];
        }
    }
    NSString *test = [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",test);
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [[self sharedAFManager]GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil, error);

    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
 
        return [[self sharedAFManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                complete(responseObject, nil);
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSError *error5 = [NSError errorWithDomain:@"请求失败" code:999 userInfo:nil];
            complete(nil, error5);
            }];
    }


+(id)again:(NSString *)path  :(NSDictionary *)dic completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [BaseNetManager POST:path parameters:dic completionHandler:complete];
    
}


+(void)cancleAllRequse
{
    [manager.operationQueue cancelAllOperations];
    [manager.session invalidateAndCancel];
}


- (void)postManyRequesttaskArr:(NSArray <void (^)()> *)arr SuccessBlock:(void (^)())success failBlock:(void (^)())failBlock{
    dispatch_group_t group = dispatch_group_create();
    //     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("并行网络请求", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i<arr.count; i++) {
        dispatch_group_async(group, queue,arr[i]);
    }
    dispatch_group_notify(group, queue, ^{
        for (int i =0; i<arr.count; i++) {
//            dispatch_semaphore_wait(kAppDelegate.semaphore, DISPATCH_TIME_FOREVER);
        }
        success();
    });
    
}


@end
