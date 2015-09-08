//
//  OrderTableViewCell.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "Header.h"
#import "OrderEvaluate.h"
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
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,5, kWindowWidth/2, 25)];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.font = [UIFont systemFontOfSize:15.0];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.timeLabel];
        
        self.statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/2, 5, kWindowWidth/2-20,30)];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.textColor = [UIColor orangeColor];
        
        self.statusLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:self.statusLabel];
        
        self.xiantiao = [[UIImageView alloc]initWithFrame:CGRectMake(20, 35, kWindowWidth-40, 0.5)];
        self.xiantiao.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.xiantiao];
        
        
        self.querenshouhuoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.querenshouhuoBtn.frame = CGRectMake(kWindowWidth-95, 109, 75, 25);
        [self.querenshouhuoBtn setBackgroundImage:[UIImage imageNamed:@"querenshouhuo"] forState:UIControlStateNormal];
        self.querenshouhuoBtn.hidden = YES;
        [self.contentView addSubview:self.querenshouhuoBtn];
        
        self.pingjiaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.pingjiaBtn.frame = CGRectMake(kWindowWidth-95, 109, 75, 25);
        [self.pingjiaBtn setBackgroundImage:[UIImage imageNamed:@"pingjia"] forState:UIControlStateNormal];
        self.pingjiaBtn.hidden = YES;
        [self.contentView addSubview:self.pingjiaBtn];

        self.img = [[UIImageView alloc]init];
        self.img.frame = CGRectMake(21, 45, 60, 60);
        [self.contentView addSubview:self.img];
        
        self.nameOfSupermarket = [[UILabel alloc]initWithFrame:CGRectMake(123, 50, 100, 14)];
        self.nameOfSupermarket.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameOfSupermarket];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(123, 80, 80, 10)];
        self.priceLabel.textColor = [UIColor grayColor];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.priceLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return  self;
}
@end
