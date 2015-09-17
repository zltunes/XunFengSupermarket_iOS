//
//  AboutViewController.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/9/15.
//  Copyright © 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface AboutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *backbtn;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *iconlabel;
@end
