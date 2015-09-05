//
//  AddressTableViewCell.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *addresslabel;
@property(nonatomic,strong)UILabel *phonelabel;
-(void)setupcell;
@end
