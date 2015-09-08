//
//  MarketCell.h
//  Final1
//
//  Created by 张悦心 on 15/7/7.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketCell : UITableViewCell
@property (nonatomic)UILabel* nameLabel;
@property (nonatomic)NSString* star;
@property (nonatomic)UILabel* monthSale;
@property (nonatomic)UILabel* moneyLabel;
@property (nonatomic)UILabel* timeLabel;
@property (nonatomic)UILabel* freeLabel;
@property (nonatomic)UIImageView* MarketView;
@property (nonatomic)UIImageView* star1;
@property (nonatomic)UIImageView* star2;
@property (nonatomic)UIImageView* star3;
@property (nonatomic)UIImageView* star4;
@property (nonatomic)UIImageView* star5;

@property (nonatomic)id data;

@end
