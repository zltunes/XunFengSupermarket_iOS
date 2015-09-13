//
//  OrderTableViewController.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableViewCell.h"
@interface OrderTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
//@property(strong,nonatomic) UINavigationBar* navbar_order;
//@property(strong,nonatomic) UINavigationItem* navitem_order;
@property(strong,nonatomic) UITableView* table;
@property(strong,nonatomic) UILabel* toregistOrloginlabel;
-(void)initOrderView;
-(void)initOrderViewAfterLogin;
@end
