//
//  RemarkCell.m
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "RemarkCell.h"
#import "Header.h"

@implementation RemarkCell
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
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.remarkField = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, kWindowWidth, 38)];
        self.remarkField.placeholder = @"备注";
        self.remarkField.returnKeyType = UIReturnKeyDone;
//      self.remarkField.enablesReturnKeyAutomatically = YES;
        //done之后自动关闭键盘
        [self.remarkField addTarget:self action:@selector(finishEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.contentView addSubview:self.remarkField];
    }
    return self;
}
-(void)finishEdit:(id)sender
{
    [sender resignFirstResponder];
}
@end
