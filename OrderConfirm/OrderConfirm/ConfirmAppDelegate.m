//
//  ConfirmAppDelegate.m
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "ConfirmAppDelegate.h"


@implementation ConfirmAppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.viewController = [[ConfirmTableViewController alloc]init];
    self.naviController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.naviController;
    
    [self.window makeKeyAndVisible];
    
    /*
     后台请求部分
     */
    
    //创建AFHTTPRequestOperationManager对象
    self.manager = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    [self.manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //请求时需要提交Access_token
    [self.manager.requestSerializer setValue:@"4244b7ac-4fbb-11e5-82bd-00163e021195" forHTTPHeaderField:@"Access_token"];
    
    //申明返回的结果是json类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    return YES;
}
@end
