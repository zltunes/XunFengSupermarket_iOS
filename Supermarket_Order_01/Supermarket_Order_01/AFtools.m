//
//  AFtools.m
//  Final1
//
//  Created by 浩然 on 15/8/10.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "AFtools.h"
#import <AFNetworking.h>

@implementation AFtools

+ (void)JSONDataWithUrl:(NSString *)url parameters: (NSDictionary *) parameters HttpHeader: (id)header success:(void (^)(id json))success fail:(void (^)())fail;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"Access_token"];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
}


+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
    
}


- (void)setToken:(NSString *)token{
    _token = token;
}


- (void)setParameters:(NSDictionary *)parameters{
    _parameters = parameters;
}

@end
