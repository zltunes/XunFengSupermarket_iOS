//
//  commentCell.m
//  Final1
//
//  Created by 浩然 on 15/7/23.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "commentCell.h"

@implementation commentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
