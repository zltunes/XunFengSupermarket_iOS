//
//  MyLogisticsTableViewCell.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/27.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "MyLogisticsTableViewCell.h"
#define screenwidth self.bounds.size.width
@implementation MyLogisticsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupcell{
    self.timelabel=[[UILabel alloc]initWithFrame:CGRectMake(21, 3, 100, 15)];
    [self addSubview:self.timelabel];
    [self.timelabel setText:@"9dian" ];
    [self.timelabel setTextColor:[UIColor grayColor]];
    UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(21, 18, 278, 2)];
    [line1 setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1]];
    [self addSubview:line1];
    self.marketname=[[UILabel alloc]initWithFrame:CGRectMake(21, 30, 150, 20)];
    [self addSubview:self.marketname];
    [self.marketname setText:@"世纪华联"];
    self.namelabel=[[UILabel alloc]initWithFrame:CGRectMake(21, 50, 60, 20)];
    [self addSubview:self.namelabel];
    [self.namelabel setText:@"用户："];
    self.namelabel1=[[UILabel alloc]initWithFrame:CGRectMake(81, 50, 200, 20)];
    self.starttimelabel=[[UILabel alloc]initWithFrame:CGRectMake(21, 90, 90, 20)];
    [self.starttimelabel setText:@"起送时间："];
    self.starttimelabel1=[[UILabel alloc]initWithFrame:CGRectMake(101, 90, 200, 20)];
    [self addSubview:self.starttimelabel1];
    [self addSubview:self.starttimelabel];
    self.addresslabel=[[UILabel alloc]initWithFrame:CGRectMake(21, 70, 80, 20)];
    [self.addresslabel setText:@"地址："];
    [self addSubview:self.addresslabel];
    self.addresslabel1=[[UILabel alloc]initWithFrame:CGRectMake(101, 70, 200, 20)];
    [self addSubview:self.addresslabel1];
    self.detailview=[[UIImageView alloc]initWithFrame:CGRectMake(242, 30, 56, 49.5)];
    [self.detailview setImage:[UIImage imageNamed:@"我的物流-01_07.png"]];
    [self addSubview:self.detailview];
    self.contactbtn=[[UIButton alloc]initWithFrame:CGRectMake(160, 118, 70, 27)];
    [self.contactbtn setTitle:@"联系顾客" forState:UIControlStateNormal];
    [self.contactbtn.layer setBorderColor:[[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0] CGColor]];
    self.contactbtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    self.contactbtn.layer.borderWidth=1.0f;
    [self.contactbtn setTitleColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]  forState:UIControlStateNormal];
    [self addSubview:self.contactbtn];
    self.arrivebtn=[[UIButton alloc]initWithFrame:CGRectMake(240, 118, 70, 27)];
    [self.arrivebtn.layer setBorderColor:[[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]CGColor]];
    self.arrivebtn.layer.borderWidth=1.0;
    [self.arrivebtn setTitleColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]  forState:UIControlStateNormal];
    self.arrivebtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [self.arrivebtn setTitle:@"已送达" forState:UIControlStateNormal];
    UIImageView*line2=[[UIImageView alloc]initWithFrame:CGRectMake(21, 112, 278, 2)];
    [line2 setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1]];
    [self addSubview:line2];
    
    [self addSubview:self.arrivebtn];
    
}

@end
