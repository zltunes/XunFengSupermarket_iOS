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
@property(nonatomic,strong)NSMutableArray* timearr;//接收起送时间数组,元素包括“id”“time”
@property(nonatomic,strong)NSMutableArray* start_timeStringArr;//只存储time(string),不存储id
@property(nonatomic,strong)NSMutableArray* start_timeIDArr;//只存储id，不存储string
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)UIButton* btn4;//去下单按钮
@property(strong,nonatomic)UIView* bottomView;
@property(strong,nonatomic)UILabel *goodsCount;
@property(strong,nonatomic)UILabel *totalPricelabel;
@property(strong,nonatomic)NSMutableDictionary* defaultAddressDict;
@property int order_id;

@property float topayPrice;//向支付界面传值（包括配送费）
//从DetailViewController获取的数据
@property int sup_id;
@property float totalGoodsPrice;//商品总价（不包括配送费）
@property NSMutableArray* goodsArr;
//goods[{"gid","quantity","name","price"},...]

@end
