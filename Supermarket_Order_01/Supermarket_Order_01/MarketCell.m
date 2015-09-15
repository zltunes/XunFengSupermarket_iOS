//
//  MarketCell.m
//  Final1
//
//  Created by 张悦心 on 15/7/7.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "MarketCell.h"
#import "Header.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
@implementation MarketCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *MarketView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 12, 75, 75)];
        MarketView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:MarketView];
        _MarketView = MarketView;
        
        UIImageView *star1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+15, CGRectGetMinY(MarketView.frame)+30, 15, 15)];
        star1.image = [UIImage imageNamed:@"2.png"];
        star1.hidden = YES;
        [self.contentView addSubview:star1];
        _star1 = star1;
        
        UIImageView *star2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+30, CGRectGetMinY(MarketView.frame)+30, 15, 15)];
        star2.image = [UIImage imageNamed:@"2.png"];
        star2.hidden = YES;
        [self.contentView addSubview:star2];
        _star2 = star2;
        
        UIImageView *star3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+45, CGRectGetMinY(MarketView.frame)+30, 15, 15)];
        star3.image = [UIImage imageNamed:@"2.png"];
        star3.hidden = YES;
        [self.contentView addSubview:star3];
        _star3 = star3;
        
        UIImageView *star4 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+60, CGRectGetMinY(MarketView.frame)+30, 15, 15)];
        star4.image = [UIImage imageNamed:@"2.png"];
        star4.hidden = YES;
        [self.contentView addSubview:star4];
        _star4 = star4;
        
        UIImageView *star5 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+75, CGRectGetMinY(MarketView.frame)+30, 15, 15)];
        star5.image = [UIImage imageNamed:@"2.png"];
        star5.hidden = YES;
        [self.contentView addSubview:star5];
        _star5 = star5;
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+15,CGRectGetMinY(MarketView.frame),100,15)];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;

        UILabel *monthSale = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+100, CGRectGetMinY(MarketView.frame)+30, 70, 12)];
        monthSale.textColor = [UIColor grayColor];
        [self.contentView addSubview:monthSale];
        _monthSale = monthSale;
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+15, CGRectGetMinY(MarketView.frame)+55, kWindowWidth*0.2, 12)];
        moneyLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:moneyLabel];
        _moneyLabel = moneyLabel;
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel.frame), CGRectGetMinY(MarketView.frame)+55, kWindowWidth*0.25, 12)];
        timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        UILabel *freeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame)+5, CGRectGetMinY(MarketView.frame)+55, kWindowWidth*0.2, 12)];
        freeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:freeLabel];
        _freeLabel = freeLabel;
        
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+15, CGRectGetMaxY(moneyLabel.frame)+10, 180, 25)];
        image1.image = [UIImage imageNamed:@"12.png"];
        [self.contentView addSubview:image1];
        
        UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MarketView.frame)+15, CGRectGetMaxY(moneyLabel.frame)+40, 100, 25)];
        image2.image = [UIImage imageNamed:@"13.png"];
        [self.contentView addSubview:image2];
        
    }
    return self;
}
- (void)setData:(id)data{
    NSString *temp = [[NSString alloc]init];
    
    _data = data;
    _nameLabel.text = _data[@"name"];
    _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    
    temp = [NSString stringWithFormat: @"%@",data[@"stars"]];
    _star = @"5";
    [self showStar];
    
    temp =  [NSString stringWithFormat: @"%@%@",@"月售",data[@"sales"]];
       _monthSale.text = temp;
    _monthSale.font = [UIFont boldSystemFontOfSize:14];

    temp = [NSString stringWithFormat: @"%@%@",data[@"min_price"],@"元起售/"];
    _moneyLabel.text = temp;
    _moneyLabel.font = [UIFont boldSystemFontOfSize:14];
    
    temp = [NSString stringWithFormat: @"%@%@",data[@"spend_time"],@"分钟送达/"];
    _timeLabel.text = temp;
    _timeLabel.font = [UIFont boldSystemFontOfSize:14];
    
    _freeLabel.text = @"免费配送";
    _freeLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [_MarketView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"icon"]]]];
    
}

- (void)showStar{
    if([_star isEqual:@"0"]){
        return;
    }
    if ([_star isEqual:@"1"]) {
        _star1.hidden = NO;
        return;
    }
    _star1.hidden = NO;
    if ([_star isEqual:@"2"]){
        _star2.hidden = NO;
        return;
    }
    _star2.hidden = NO;
    
    if ([_star isEqual:@"3"]) {
        _star3.hidden = NO;
        return;
    }
    _star3.hidden = NO;
    
    if ([_star isEqual:@"4"]) {
        _star4.hidden = NO;
        return;
    }
    _star4.hidden = NO;
    
    if ([_star isEqual:@"5"]) {
        _star5.hidden = NO;
        return;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
