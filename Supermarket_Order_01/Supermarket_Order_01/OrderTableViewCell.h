//
//  OrderTableViewCell.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

@property(strong,nonatomic) UILabel* timeLabel;
@property(strong,nonatomic) NSString* OrderStatus;
@property(strong,nonatomic) UILabel* statusLabel;
@property(strong,nonatomic) UIButton* querenshouhuoBtn;
@property(strong,nonatomic) UIButton* pingjiaBtn;
@property(strong,nonatomic) UIImageView* img;
@property(strong,nonatomic) UILabel* nameOfSupermarket;
@property(strong,nonatomic) UILabel* priceLabel;
@property(strong,nonatomic) UIImageView* xiantiao;

@end
