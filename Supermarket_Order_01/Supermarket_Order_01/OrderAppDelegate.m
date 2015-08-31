//
//  OrderAppDelegate.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderAppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

@implementation OrderAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"9fe7e6337ac0" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
                //新浪微博
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"2573964743" appSecret:@"816b538e7d806552e0f212ec281f360a" redirectUri:@"https://github.com/seuzl/XunFengSupermarket_iOS" authType:SSDKAuthTypeBoth];
                break;
                //微信平台
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx1adc6982d78372d6" appSecret:@"289d95b44a2b3a25ee1956c68d9af434"];
                break;
                //qq平台
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"1104759701" appKey:@"k66I0cXnfdcKGkTc" authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    }];
    
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
