//
//  OrderAppDelegate.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableViewController.h"
#import "AFNetworking.h"
#import "ViewController1.h"
#import "myViewController.h"

@interface OrderAppDelegate : UIResponder<UIApplicationDelegate,UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
//三个tab各自设置一个navigationController
@property(strong,nonatomic) UINavigationController *naviController_order;//order导航栏控制器
@property(strong,nonatomic) UINavigationController *naviController_sup;//sup导航栏控制器

@property(strong,nonatomic) UITabBarController* tabbarcontroller;//tabbar控制器

@property(strong,nonatomic) ViewController1* vc1;//超市首页
@property(strong,nonatomic) OrderTableViewController *viewController;//订单首页
@property(strong,nonatomic) myViewController* vc3;//个人首页

@property(strong,nonatomic) AFHTTPRequestOperationManager* manager;

@property int orderID;//订单id
@property int superID;//超市id

@end
