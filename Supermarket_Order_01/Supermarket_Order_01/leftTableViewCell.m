//
//  leftTableViewCell.m
//  Final1
//
//  Created by 张悦心 on 15/7/8.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "leftTableViewCell.h"

@implementation leftTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 50)];
        view1.backgroundColor = [UIColor colorWithRed:255.0/255 green:127.0/255 blue:0.0/255 alpha:1];
        view1.hidden = YES;
        [self.contentView addSubview:view1];
        _view1 = view1;
        
        UILabel *nameText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,100,50)];
        nameText.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameText];
        _nameText = nameText;
        
    }
    return self;
}

- (void)setName:(NSString *)name{
    _name = name;
    _nameText.text = _name;
    _nameText.textAlignment=NSTextAlignmentCenter;
    _nameText.font = [UIFont boldSystemFontOfSize:14];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
