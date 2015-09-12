//
//  detailedOrderStatusTableViewController.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/28.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderStatusCell.h"
#import "MyEvaluateCell.h"
#import "purchaseBagCell.h"
#import "MyEvaluateCell.h"
#import "PraiseView.h"

@interface detailedOrderStatusTableViewController : UITableViewController<UIPopoverListViewDataSource, UIPopoverListViewDelegate,UIAlertViewDelegate,PraiseDelegate>
@property(strong,nonatomic) UIApplication* app;//为实现拨号功能
@property(strong,nonatomic) NSString* OrderStatus;
@property(strong,nonatomic) UIBarButtonItem* shareBtn;
@property(strong,nonatomic) UIBarButtonItem* callBtn;
@property(strong,nonatomic) UIPopoverListView *poplistview;
@property(strong,nonatomic) PraiseView* praiseView;
@end
