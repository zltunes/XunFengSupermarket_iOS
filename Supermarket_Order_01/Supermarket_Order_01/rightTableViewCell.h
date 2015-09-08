//
//  rightTableViewCell.h
//  Final1
//
//  Created by 张悦心 on 15/7/8.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface rightTableViewCell : UITableViewCell
@property (nonatomic)UILabel* nameLabel;
@property (nonatomic)UILabel* saleLabel;
@property (nonatomic)UILabel* priceLabel;
@property (nonatomic)NSMutableDictionary* data;
@property (nonatomic)UIButton* leftBtn;
@property (nonatomic)UIButton* rightBtn;
@property (nonatomic)UILabel* num;
@property (nonatomic)NSInteger* singleNum;
@property (nonatomic)UIImageView* pic;
//给赵磊的array
@property (nonatomic)NSMutableArray *zL;
@property (nonatomic)NSUInteger index;
@property (nonatomic)int *intTemp;
@property (nonatomic)NSMutableDictionary *chooseDic;

@property (nonatomic)UILabel* bottomPriceLabel;

- (void)leftBtnSelect:(id)sender;
- (void)rightBtnSelect:(id)sender;
@end
