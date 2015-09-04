//
//  MyEvaluateCell.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/29.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//
#import "Header.h"
#import "MyEvaluateCell.h"

@implementation MyEvaluateCell

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
        self.myEvaluateView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5,kWindowWidth-20, 100)];
        self.myEvaluateView.editable = NO;
        self.myEvaluateView.layer.borderColor = [[UIColor grayColor]CGColor];
        self.myEvaluateView.layer.borderWidth = 1;
        [self.contentView addSubview:self.myEvaluateView];
    }
    return self;
}
@end
