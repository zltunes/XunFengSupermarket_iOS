//
//  commentCell.m
//  Final1
//
//  Created by 浩然 on 15/7/23.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "commentCell.h"
#import "Header.h"

@implementation commentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *phoneNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,kWindowWidth*0.3 , 20)];
        phoneNum.font = [UIFont boldSystemFontOfSize:14];
        phoneNum.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:phoneNum];
        _phoneNum = phoneNum;
        
        
        
        UILabel *dataLab = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth*0.6-10, 10, kWindowWidth*0.35, 20)];
        dataLab.font = [UIFont boldSystemFontOfSize:12];
        dataLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:dataLab];
        _dataLab = dataLab;
        
        UILabel *commentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, kWindowWidth, 20)];
        commentLab.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:commentLab];
        _commentLab = commentLab;
        
        
        UIImageView *star1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30 , 10, 10)];
        star1.image = [UIImage imageNamed:@"2.png"];
        star1.hidden = YES;
        [self.contentView addSubview:star1];
        _star1 = star1;
        
        UIImageView *star2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,30,10,10)];
        star2.image = [UIImage imageNamed:@"2.png"];
        star2.hidden = YES;
        [self.contentView addSubview:star2];
        _star2 = star2;
        
        UIImageView *star3 = [[UIImageView alloc]initWithFrame:CGRectMake(30,30,10,10)];
        star3.image = [UIImage imageNamed:@"2.png"];
        star3.hidden = YES;
        [self.contentView addSubview:star3];
        _star3 = star3;
        
        UIImageView *star4 = [[UIImageView alloc]initWithFrame:CGRectMake(40,30,10,10)];
        star4.image = [UIImage imageNamed:@"2.png"];
        star4.hidden = YES;
        [self.contentView addSubview:star4];
        _star4 = star4;
        
        UIImageView *star5 = [[UIImageView alloc]initWithFrame:CGRectMake(50,30,10,10)];
        star5.image = [UIImage imageNamed:@"2.png"];
        star5.hidden = YES;
        [self.contentView addSubview:star5];
        _star5 = star5;

        
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    
    _star = [NSString stringWithFormat:@"%@",dataDic[@"stars"]];
    //NSLog(@"%@",_star);

    [self showStar];
    
    _commentLab.text = [NSString stringWithFormat:@"%@",dataDic[@"content"]];
    
    _phoneNum.text = [NSString stringWithFormat:@"%@",dataDic[@"phone_num"]];
    
    _dataLab.text = [NSString stringWithFormat:@"%@",dataDic[@"time"]];
}

- (void)showStar{
    if([_star isEqualToString:@"0"]){
        return;
    }
    if ([_star isEqualToString:@"1"]) {
        _star1.hidden = NO;
        return;
    }
    _star1.hidden = NO;
    if ([_star isEqualToString:@"2"]){
        _star2.hidden = NO;
        return;
    }
    _star2.hidden = NO;
    
    if ([_star isEqualToString:@"3"]) {
        _star3.hidden = NO;
        return;
    }
    _star3.hidden = NO;

    if ([_star isEqualToString:@"4"]) {
        _star4.hidden = NO;
        return;
    }
    _star4.hidden = NO;
    
    if ([_star isEqualToString:@"5"]) {
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
