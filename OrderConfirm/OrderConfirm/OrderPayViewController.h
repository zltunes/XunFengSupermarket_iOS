//
//  OrderPayViewController.h
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/26.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSYPopoverListView.h"//优惠券

@interface OrderPayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZSYPopoverListDatasource, ZSYPopoverListDelegate,UIAlertViewDelegate>
@property(strong,nonatomic) UITableView* table;
@property(strong,nonatomic) UIButton* confirmPayBtn;
@property(strong,nonatomic) NSIndexPath* lastIndexPath;
@property(strong,nonatomic) UITableViewCell* couponCell;//购物券cell
@property NSInteger couponCount;//购物券值
@property float banlance;//我的余额
@property float toPayValue;//还需支付
@end
