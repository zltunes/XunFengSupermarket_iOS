//
//  OrderAppDelegate.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//
#import "Header.h"
#import "OrderAppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import <SMS_SDK/SMS_SDK.h>

@implementation OrderAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [SMS_SDK registerApp:@"9fe7e6337ac0" withSecret:@"a914aca08f774bf058efdd61fd95f963"];//mob后台获取
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
    
    //1.初始化“超市”界面
    self.vc1 = [[ViewController1 alloc]init];
    self.naviController_sup = [[UINavigationController alloc]initWithRootViewController:self.vc1];
    self.naviController_sup.navigationBar.barTintColor = [UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    self.vc1.title = @"超  市";
//    UIImage* sup_selected = [UIImage imageNamed:@"sup_selected.png"];
//    UIImage* sup_noselected = [UIImage imageNamed:@"sup_noselected.png"];
//    [self.vc1.tabBarItem setImageInsets:UIEdgeInsetsMake(5.0, 0.0, -7.0, 0.0)];
//    sup_selected = [self reSizeImage:sup_selected toSize:CGSizeMake(44, 44)];
//    sup_noselected = [self reSizeImage:sup_noselected toSize:CGSizeMake(44, 44)];
//    self.vc1.tabBarItem.selectedImage = [sup_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.vc1.tabBarItem.image = [sup_noselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.vc1.navigationItem.title = @"超  市";
    
    //2.初始化“订单”界面
    self.viewController = [[OrderTableViewController alloc]init];
    self.naviController_order = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    self.naviController_order.navigationBar.barTintColor = [UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    self.viewController.title = @"订  单";
//    UIImage* order_selected = [UIImage imageNamed:@"order_selected"];
//    UIImage* order_noselected = [UIImage imageNamed:@"order_noselected.png"];
//    [self.viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(5.0, 0.0, -7.0, 0.0)];
//    order_selected = [self reSizeImage:order_selected toSize:CGSizeMake(44, 44)];
//    order_noselected = [self reSizeImage:order_noselected toSize:CGSizeMake(44, 44)];
//    self.viewController.tabBarItem.selectedImage = [order_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.viewController.tabBarItem.image = [order_noselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.viewController.navigationItem.title = @"订  单";
    
    //3.初始化“我的”界面
    self.vc3 = [[myViewController alloc]init];
    self.vc3.title = @"我的";
//    UIImage* my_selected = [UIImage imageNamed:@"my_selected"];
//    UIImage* my_noselected = [UIImage imageNamed:@"my_noselected.png"];
//    [self.vc3.tabBarItem setImageInsets:UIEdgeInsetsMake(5.0, 0.0, -7.0, 0.0)];
//    my_selected = [self reSizeImage:my_selected toSize:CGSizeMake(44, 44)];
//    my_noselected = [self reSizeImage:my_noselected toSize:CGSizeMake(44, 44)];
//    self.vc3.tabBarItem.selectedImage = [my_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.vc3.tabBarItem.image = [my_noselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    //4.初始化tabbarcontroller
    self.tabbarcontroller=[[UITabBarController alloc]init];
    self.tabbarcontroller.delegate=self;
    self.tabbarcontroller.viewControllers=[NSArray arrayWithObjects:self.naviController_sup,self.naviController_order,self.vc3,nil];
    
    
    //5.设置窗口以tabbarcontroller为根视图控制器
    self.window.rootViewController=self.tabbarcontroller;
    
    [self.window makeKeyAndVisible];
    
    /*
     后台请求部分
     */
    
    //创建AFHTTPRequestOperationManager对象
    self.manager = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    [self.manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    //Access_token
     [self.manager.requestSerializer setValue:@"4244b7ac-4fbb-11e5-82bd-00163e021195" forHTTPHeaderField:@"Access_token"];
    
    //申明返回的结果是json类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    
    return YES;
}
-(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end
