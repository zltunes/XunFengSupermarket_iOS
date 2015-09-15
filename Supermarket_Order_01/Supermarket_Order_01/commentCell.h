//
//  commentCell.h
//  Final1
//
//  Created by 浩然 on 15/7/23.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentCell : UITableViewCell

@property(nonatomic)UILabel *phoneNum;
@property(nonatomic)UILabel *commentLab;
@property(nonatomic)UILabel *dataLab;

@property(nonatomic)NSMutableDictionary *dataDic;

@property (nonatomic)UIImageView* star1;
@property (nonatomic)UIImageView* star2;
@property (nonatomic)UIImageView* star3;
@property (nonatomic)UIImageView* star4;
@property (nonatomic)UIImageView* star5;

@property (nonatomic)NSString *star;

@end
