//
//  myViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/15.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UINavigationBar *navbar;
@property(nonatomic,strong)UINavigationItem *navitem;
@property(nonatomic,strong)UITableView *tableview;
@property bool islogin;
@end
