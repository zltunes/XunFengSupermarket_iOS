//
//  HelpTableViewCell.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/14.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "HelpTableViewCell.h"

@implementation HelpTableViewCell
@synthesize arrow_down,arrow_up,textlabel,leftimg;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.textLabel.text = text;
    //设置label的最大行数
    self.textLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.textlabel.text sizeWithFont:self.textlabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.textlabel.frame = CGRectMake(self.textlabel.frame.origin.x, self.textlabel.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height;
    
    self.frame = frame;
}

- (void) setOpen
{
    [arrow_down setHidden:YES];
    [arrow_up setHidden:NO];
    [self setIsOpen:YES];
}

- (void) setClosed
{
    [arrow_down setHidden:NO];
    [arrow_up setHidden:YES];
    [self setIsOpen:NO];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
