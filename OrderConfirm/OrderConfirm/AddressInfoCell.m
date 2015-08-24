//
//  AddressInfoCell.m
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "AddressInfoCell.h"

@implementation AddressInfoCell
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
    if(self){
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(57, 16, 200, 18)];
    self.addressLabel.text = @"东南大学九龙湖校区梅园1";
    [self.contentView addSubview:self.addressLabel];
    
    self.phoneNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(57, 40, 200, 18)];
    self.phoneNoLabel.text = @"15651907759";
    [self.contentView addSubview:self.phoneNoLabel];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return self;
}
@end
