//
//  OrderPayViewController.h
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/26.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSYPopoverListView.h"//优惠券
#import "PraiseView.h"

@interface OrderPayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ZSYPopoverListDatasource, ZSYPopoverListDelegate,UIAlertViewDelegate>
@property(strong,nonatomic) UITableView* table;
@property(strong,nonatomic) UIButton* confirmPayBtn;
@property(strong,nonatomic) NSIndexPath* lastIndexPath;
@property(strong,nonatomic) UITableViewCell* couponCell;//购物券cell
@property float banlance;//我的余额
@property float toPayValue;//还需支付
@property int couponCount;
@property float totalPrice;//总价
@property int order_id;
@end
