//
//  CouponViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponTableViewCell.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
#import "OrderAppDelegate.h"

@interface CouponViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    OrderAppDelegate* appdelegate;
    NSString* couponURL;
    NSMutableArray* couponArray;
}

@end

@implementation CouponViewController

- (void)viewDidLoad {
    appdelegate = [UIApplication sharedApplication].delegate;
    couponURL = @"http://115.29.197.143:8999/v1.0/coupons";
    couponArray = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"我的购物券"];
    [navbar pushNavigationItem:navitem animated:NO];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    navbar.titleTextAttributes=attrdic;
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]init];
    self.backbtn=[[UIButton alloc]initWithFrame:CGRectMake(9, 30,20.5, 33)];
    [self.backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backitem setCustomView:self.backbtn];
    [navitem setLeftBarButtonItem:backitem];

    [appdelegate.manager GET:couponURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        couponArray = responseObject;
        self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 74, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view addSubview:self.tableview];
        [self.tableview registerClass:[CouponTableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableview.delegate=self;
        self.tableview.dataSource=self;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    // Do any additional setup after loading the view.
}

-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [couponArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            //[{id,price,state,timelimit}]
    static NSString *CellWithIdentifier = @"cell";
    CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    NSMutableDictionary* couponDict = [[NSMutableDictionary alloc]init];
    couponDict = [couponArray objectAtIndex:indexPath.section];
    [cell setupcell];
    [cell.timelabel setText:[NSString stringWithFormat:@"有效期至%@",couponDict[@"timelimit"]]];
    [cell.timelabel setFont:[UIFont systemFontOfSize:13.0]];
    [cell.numlabel setText:[NSString stringWithFormat:@"¥ %@",couponDict[@"price"]]];
    [cell.numlabel setFont:[UIFont systemFontOfSize:25.0]];
    [cell.numlabel sizeToFit];
    [cell.numlabel setTextColor:[UIColor orangeColor]];
    if ([couponDict[@"state"] isEqualToString:@"timeout"]) {
        cell.statelabel.text = @"过期";
        cell.statelabel.textColor = [UIColor grayColor];
    } else {
        cell.statelabel.text = @"可用";
        cell.statelabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
