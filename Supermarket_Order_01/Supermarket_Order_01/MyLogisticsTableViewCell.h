//
//  MyLogisticsTableViewCell.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/27.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLogisticsTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *timelabel;
@property(nonatomic,strong)UILabel *marketname;
@property(nonatomic,strong)UILabel* namelabel;
@property(nonatomic,strong)UILabel* namelabel1;
@property(nonatomic,strong)UILabel* addresslabel;
@property(nonatomic,strong)UILabel*addresslabel1;
@property(nonatomic,strong)UILabel*starttimelabel;
@property(nonatomic,strong)UILabel*starttimelabel1;
@property(nonatomic,strong)UILabel*statelabel;
@property(nonatomic,strong)UIImageView*detailview;
@property(nonatomic,strong)UIButton* contactbtn;
@property(nonatomic,strong)UIButton* arrivebtn;

-(void)setupcell;
@end
