//
//  CouponTableViewCell.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *numlabel;
@property(nonatomic,strong)UILabel*timelabel;
@property(nonatomic,strong)UILabel *statelabel;
-(void)setupcell;
@end
