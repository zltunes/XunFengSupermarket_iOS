//
//  NewAddrViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//
#import "Header.h"
#import "NewAddrViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
#import "OrderAppDelegate.h"
#import "AddressViewController.h"

@interface NewAddrViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    OrderAppDelegate* appdelegate;
}

@end

@implementation NewAddrViewController

- (void)viewDidLoad {
    appdelegate = [UIApplication sharedApplication].delegate;
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"添加收货人信息"];
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
    
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    UIImageView *whiteview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 72, self.view.bounds.size.width, 130)];
    [whiteview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteview];
    UILabel *addrlabel=[[UILabel alloc]initWithFrame:CGRectMake(18, 80, 60, 30)];
    [addrlabel setText:@"地址"];
    [addrlabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:addrlabel];
    self.addressfield=[[UITextField alloc]initWithFrame:CGRectMake(82, 80, 200, 30)];
    [self.view addSubview:self.addressfield];
    self.addressfield.placeholder=@"请填写收货地址";
    UIImageView* line1=[[UIImageView alloc]initWithFrame:CGRectMake(18, 112, 284, 1)];
    line1.backgroundColor=[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [self.view addSubview:line1];
    
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(18, 120, 60, 30)];
    [phonelabel setText:@"电话"];
    [phonelabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:phonelabel];
    self.phonefield=[[UITextField alloc]initWithFrame:CGRectMake(82, 120, 200, 30)];
    self.phonefield.placeholder = @"请填写收件人电话";
    [self.view addSubview:self.phonefield];

    UIImageView* line2=[[UIImageView alloc]initWithFrame:CGRectMake(18, 152, 284, 1)];
    line2.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    [self.view addSubview:line2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, self.view.bounds.size.width-20, 30)];
    [label3 setTextColor:[UIColor grayColor]];
    [self.view addSubview:label3];
    [label3 setText:@"请精确到宿舍号,方便我们送货上门哦"];

    UIButton* savebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    savebtn.frame = CGRectMake(25, kWindowHeight-300, kWindowWidth-50, 50);
//    [savebtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebtn setBackgroundImage:[UIImage imageNamed:@"save-01.png"] forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    // Do any additional setup after loading the view.
}


-(void)save{

    NSDictionary *parameters = @{@"phone_num":self.phonefield.text,@"address":self.addressfield.text};
    [appdelegate.manager  POST:@"http://115.29.197.143:8999/v1.0/user/address" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        AddressViewController* addressViewController = [[AddressViewController alloc]init];
        NSDictionary* add_id_dic = responseObject;
        NSDictionary* newadddic = @{@"phone_num":self.phonefield.text,@"address":self.addressfield.text,@"id":add_id_dic[@"id"]};
        [addressViewController.addressArr addObject:newadddic];
        [addressViewController.tableview reloadData];
        [self presentViewController:addressViewController animated:NO completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"添加新地址失败!%@", error);
    }];

    
}
-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
