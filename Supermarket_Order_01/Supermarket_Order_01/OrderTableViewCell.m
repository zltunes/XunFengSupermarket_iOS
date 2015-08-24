//
//  OrderTableViewCell.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "Header.h"
@implementation OrderTableViewCell

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
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, kWindowWidth/2, 30)];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
//        self.timeLabel.text = @"今天12:00";
        [self.contentView addSubview:self.timeLabel];
        
        self.statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/2, 0, kWindowWidth/2,30)];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.text = nil;
        [self.contentView addSubview:self.statusLabel];
        
        self.statusBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.statusBtn.frame = CGRectMake(kWindowWidth-75, 109, 75, 25);
        [self.statusBtn setTitle:nil forState:UIControlStateNormal];
        [self.contentView addSubview:self.statusBtn];

//        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test.jpg"]];
        self.img.frame = CGRectMake(21, 40, 60, 60);
        [self.contentView addSubview:self.img];
        
        self.nameOfSupermarket = [[UILabel alloc]initWithFrame:CGRectMake(123, 45, 75, 14)];
//        self.nameOfSupermarket.text = @"世纪华联";
        self.nameOfSupermarket.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameOfSupermarket];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(123, 70, 75, 10)];
//        self.priceLabel.text = @"￥99.0";
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.priceLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return  self;
}

@end
