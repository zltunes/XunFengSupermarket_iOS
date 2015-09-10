//
//  AddressViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UINavigationBar *navbar;
@property(nonatomic,strong)UINavigationItem *navitem;
@property(nonatomic,strong)UIButton *backbtn;
@property(nonatomic,strong)UIButton *addbtn;
@property(nonatomic,strong)NSMutableArray *datasource;
@property(nonatomic,strong)NSMutableArray* addressArr;
@property int canBeSelected;
@end
