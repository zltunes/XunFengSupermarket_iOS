//
//  myTableViewCell.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/15.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "myTableViewCell.h"

@implementation myTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupcell{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.leftimg=[[UIImageView alloc]initWithFrame:CGRectMake(18, 10, 20, 20)];
    [self addSubview:self.leftimg];
    self.leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(53, 10, 100,20 )];
    [self addSubview:self.leftlabel];
    self.rightlabel=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-150, 10, 130, 20)];
    [self.rightlabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:self.rightlabel];
}

@end
