//
//  myTableViewCell.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/15.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftimg;
@property(nonatomic,strong)UILabel *leftlabel;
@property(nonatomic,strong)UIImageView *rightimg;

-(void)setupcell;
@end
