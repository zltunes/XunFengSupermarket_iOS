//
//  CarCell.h
//  Supermarket_Order_01
//
//  Created by 浩然 on 15/9/10.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rightTableViewCell.h"
//#import "ShoppingCarView.h"

@protocol ShoppingCarViewDelegate <NSObject>
- (void)CarViewDataReload;

@end


@interface CarCell : UITableViewCell
@property (nonatomic)UILabel *nameLabel;
@property (nonatomic)UILabel *priceLabel;
@property (nonatomic)NSMutableDictionary *goodDic;

@property(nonatomic)UIButton *leftBtn;
@property(nonatomic)UIButton *rightBtn;
@property(nonatomic)UILabel *numLabel;

@property(nonatomic)rightTableViewCell *tempCell;

@property(nonatomic)UITableView *carTable;

@property(nonatomic)id<ShoppingCarViewDelegate>delegate;
@end
