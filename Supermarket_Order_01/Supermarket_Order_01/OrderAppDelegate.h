//
//  OrderAppDelegate.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OrderTableViewController.h"
#import "AFNetworking.h"
#import "myViewController.h"
#import "RootViewController.h"

@interface OrderAppDelegate : UIResponder<UIApplicationDelegate,UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

//tabbarController
@property(strong,nonatomic) UITabBarController* tabbarcontroller;//tabbar控制器

//三个tab各自设置一个navigationController
@property(strong,nonatomic) UINavigationController *naviController_order;//order导航栏控制器
@property(strong,nonatomic) UINavigationController *naviController_sup;//sup导航栏控制器
@property(strong,nonatomic) UINavigationController *naviController_vc3;//vc3导航栏控制器

//三个rootViewController
@property(strong,nonatomic) RootViewController* rootViewController;//超市首页
@property(strong,nonatomic) OrderTableViewController *viewController;//订单首页
@property(strong,nonatomic) myViewController* vc3;//个人首页

@property(strong,nonatomic) AFHTTPRequestOperationManager* manager;

@property int orderID;//订单id
@property int superID;//超市id

//supermarketview所需
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//access_token
//存储access_token的plist文件
@property bool islogin;
@property(strong,nonatomic) NSString* filename;
@property(strong,nonatomic) NSMutableDictionary* plistdic;
@property(strong,nonatomic) NSString* access_token;
@end
