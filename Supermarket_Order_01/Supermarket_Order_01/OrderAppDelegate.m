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
    self.rootViewController = [[RootViewController alloc]init];
    self.naviController_sup = [[UINavigationController alloc]initWithRootViewController:self.rootViewController];
    self.naviController_sup.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    [self.naviController_sup.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.rootViewController.title = @"超  市";
    
//    UIImage* sup_selected = [UIImage imageNamed:@"sup_selected.png"];
//    UIImage* sup_noselected = [UIImage imageNamed:@"sup_noselected.png"];
//    [self.rootViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(5.0, 0.0, -7.0, 0.0)];
//    sup_selected = [self reSizeImage:sup_selected toSize:CGSizeMake(44, 44)];
//    sup_noselected = [self reSizeImage:sup_noselected toSize:CGSizeMake(44, 44)];
//    self.rootViewController.tabBarItem.selectedImage = [sup_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.rootViewController.tabBarItem.image = [sup_noselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.rootViewController.navigationItem.title = @"超  市";
    
    //2.初始化“订单”界面
    self.viewController = [[OrderTableViewController alloc]init];
    self.naviController_order = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    self.naviController_order.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    [self.naviController_order.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
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
    self.naviController_vc3 = [[UINavigationController alloc]initWithRootViewController:self.vc3];
        self.naviController_vc3.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    [self.naviController_vc3.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.vc3.title = @"我  的";
    
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
    self.tabbarcontroller.viewControllers=[NSArray arrayWithObjects:self.naviController_sup,self.naviController_order,self.naviController_vc3,nil];
    
    
    //5.设置窗口以tabbarcontroller为根视图控制器
    self.window.rootViewController=self.tabbarcontroller;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.filename= [documentsDirectory stringByAppendingPathComponent:@"personinfo.plist"];
    self.plistdic=[[[NSMutableDictionary alloc]initWithContentsOfFile:self.filename]mutableCopy];
    if(self.plistdic==nil){
        self.islogin=NO;
        self.plistdic=[[NSMutableDictionary alloc]init];
        NSMutableArray *values=[[NSMutableArray alloc]initWithCapacity:10];;
        NSMutableArray *keys=[[NSMutableArray alloc]initWithCapacity:10];
        
        [values addObject:@"0"];
        [values addObject:@"0"];
        [values addObject:@""];
        
        [keys addObject:@"islogin"];
        [keys addObject:@"tel"];
        [keys addObject:@"access_token"];
        
        self.plistdic = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
        [self.plistdic writeToFile:self.filename atomically:YES];

    }
    else{
        if([[self.plistdic objectForKey:@"islogin"]isEqualToString:@"1"])
            _islogin=YES;
        else
            _islogin=NO;
        self.access_token = [self.plistdic objectForKey:@"access_token"];
        NSLog(@"access_token:%@",self.access_token);
    }
    /*
     后台请求部分
     */
    
    //创建AFHTTPRequestOperationManager对象
    self.manager = [AFHTTPRequestOperationManager manager];
    //申明请求的数据是json类型
    [self.manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    //Access_token
     [self.manager.requestSerializer setValue:self.access_token forHTTPHeaderField:@"access_token"];
    
    //申明返回的结果是json类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
  
    [self.window makeKeyAndVisible];
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
//超市界面所需

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-.Final1" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Final1" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Final1.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
