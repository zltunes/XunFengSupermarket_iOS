//
//  purchaseBagCell.m
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/28.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "purchaseBagCell.h"
#import "Header.h"
@implementation purchaseBagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    self.goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kWindowWidth/2, 40)];
    [self.contentView addSubview:self.goodsNameLabel];
    self.goodsCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/2,0,kWindowWidth/4,40)];
        self.goodsCountLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.goodsCountLabel];
    self.totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.75*kWindowWidth, 0, kWindowWidth/4-20, 40)];
        self.totalPriceLabel.textAlignment = NSTextAlignmentRight;
        self.totalPriceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.totalPriceLabel];
    }
    return self;
}
@end
