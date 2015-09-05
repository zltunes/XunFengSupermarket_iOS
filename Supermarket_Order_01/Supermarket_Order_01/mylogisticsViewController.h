//
//  mylogisticsViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/27.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mylogisticsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property UITableView *tableview;
@property(nonatomic,strong)UIButton* deliveringbtn;
@property(nonatomic,strong)UIButton *deliveredbtn;
@property(nonatomic,strong)UIButton *backbtn;
@property(nonatomic,strong)UINavigationBar *navbar;
@property(nonatomic,strong)UINavigationItem *navitem;
@property(nonatomic,strong)NSMutableDictionary *datasource;
@end
