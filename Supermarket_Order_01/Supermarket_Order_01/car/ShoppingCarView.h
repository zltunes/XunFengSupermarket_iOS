//
//  ShoppingCarView.h
//  Supermarket_Order_01
//
//  Created by 浩然 on 15/9/10.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarCell.h"

@interface ShoppingCarView : UIView <UITableViewDelegate,UITableViewDataSource,ShoppingCarViewDelegate>

@property (nonatomic)UITableView *carGoods;
@property (nonatomic)NSInteger *num;
@property (nonatomic)NSMutableArray *goodArray;


@end
