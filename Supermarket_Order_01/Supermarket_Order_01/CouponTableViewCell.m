//
//  CouponTableViewCell.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupcell{
    self.numlabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 21, 30, 60)];
    [self addSubview:self.numlabel];
    self.timelabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, self.bounds.size.width-180, 50)];
    [self addSubview:self.timelabel];
    self.statelabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-80, 10, 70, 50)];
    [self addSubview:self.statelabel];
    
}
@end
