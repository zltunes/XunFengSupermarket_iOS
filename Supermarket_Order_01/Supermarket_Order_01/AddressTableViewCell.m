//
//  AddressTableViewCell.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupcell{
    self.addresslabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 260, 40)];
    [self addSubview:self.addresslabel];
    self.phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, 260, 40)];
    [self addSubview:self.phonelabel];
}
@end
