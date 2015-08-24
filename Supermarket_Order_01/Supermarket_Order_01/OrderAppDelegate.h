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

@interface OrderAppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UINavigationController *naviController;
@property(strong,nonatomic) OrderTableViewController *viewController;
@property(strong,nonatomic) AFHTTPRequestOperationManager* manager;
@property(strong,nonatomic) NSNumber* orderID;//订单id
@property(strong,nonatomic) NSNumber* superID;//超市id
@end
