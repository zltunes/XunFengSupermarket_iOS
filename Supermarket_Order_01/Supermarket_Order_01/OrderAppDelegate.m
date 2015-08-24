//
//  OrderAppDelegate.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderAppDelegate.h"

@implementation OrderAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //1⃣️初始化viewController:
    self.viewController = [[OrderTableViewController alloc]initWithStyle:UITableViewStylePlain];
    
    //2⃣️初始化naviController，以self.viewController为视图栈最底层控件
    self.naviController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    //3⃣️设置窗口以naviController为根视图控制器
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
    
    //Access_token
     [self.manager.requestSerializer setValue:@"b07f18c8-3f14-11e5-82bd-00163e021195" forHTTPHeaderField:@"Access_token"];
    
    //申明返回的结果是json类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    return YES;
}

@end
