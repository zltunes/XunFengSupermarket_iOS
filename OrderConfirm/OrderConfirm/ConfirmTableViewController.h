//
//  ConfirmTableViewController.h
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPickView.h"

@interface ConfirmTableViewController : UIViewController<ZHPickViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView* table;
@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(strong,nonatomic)UIToolbar *toolbar;
@property(strong,nonatomic)UILabel *goodsCount;
@property(strong,nonatomic)UILabel *totalPrice;
@property(strong,nonatomic)NSNumber* totalgoodsPrice;//向支付界面传值
@end
