//
//  AFtools.h
//  Final1
//
//  Created by 浩然 on 15/8/10.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFtools : NSObject
+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;
+ (void)JSONDataWithUrl:(NSString *)url parameters: (NSDictionary *) parameters HttpHeader: (NSString *)header success:(void (^)(id json))success fail:(void (^)())fail;
@property (nonatomic) NSString *token;
@property (nonatomic) NSDictionary *parameters;
@end
