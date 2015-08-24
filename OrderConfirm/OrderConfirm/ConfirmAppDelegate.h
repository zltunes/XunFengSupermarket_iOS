//
//  ConfirmAppDelegate.h
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmTableViewController.h"
#import "OrderPayViewController.h"
#import "AFNetworking.h"

@interface ConfirmAppDelegate : UIResponder

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UINavigationController *naviController;
@property(strong,nonatomic) ConfirmTableViewController *viewController;
@property(strong,nonatomic) OrderPayViewController* payViewController;
@property(strong,nonatomic) AFHTTPRequestOperationManager* manager;
@end
