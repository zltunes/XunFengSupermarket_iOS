//
//  AddressViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//
#import "Header.h"
#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "NewAddrViewController.h"
#import "EditAddrViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
#import "ConfirmTableViewController.h"
#import "OrderAppDelegate.h"

@interface AddressViewController (){
    int deleterow;
     NSArray *deletearray;
    NSIndexPath* deleteIndexPath;
    OrderAppDelegate* appdelegate;
}

@end

@implementation AddressViewController
@synthesize navbar;
@synthesize navitem;
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = [UIApplication sharedApplication].delegate;
    deleteIndexPath = [[NSIndexPath alloc]init];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
//    self.datasource=[[NSMutableArray alloc]init];
    _addressArr = [[NSMutableArray alloc]init];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [self.navbar addSubview:view1];
    //self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    //self.navigationItem.title=@"我的";
    navitem=[[UINavigationItem alloc]initWithTitle:nil];
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
    [self.navitem setLeftBarButtonItem:backitem];
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, kWindowHeight-200)];
    [self.tableview registerClass:[AddressTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.view addSubview:self.tableview];
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
//    self.addbtn=[[UIButton alloc]initWithFrame:CGRectMake(kWindowWidth-50, 225, 25, 25)];
    self.addbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.addbtn.frame = CGRectMake(25, kWindowHeight-100, kWindowWidth-50,50);
    [self.addbtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [self.view addSubview:self.addbtn];
    [self.addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];

    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];    //如果报接受类型不一致请替换一致text/html或别的
//    
//    [manager.requestSerializer setValue:@"b07f18c8-3f14-11e5-82bd-00163e021195"forHTTPHeaderField:@"Access_token"];
//    //[manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"]
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    
    [appdelegate.manager GET:@"http://115.29.197.143:8999/v1.0/user/addresses" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.addressArr=[responseObject mutableCopy];
            [self.tableview reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
-(void)add{
    NewAddrViewController *newaddrvc=[[NewAddrViewController alloc]init];
    [self presentViewController:newaddrvc animated:NO completion:nil];
}

-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.addressArr count];
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
    static NSString *CellWithIdentifier = @"cell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if(cell.addresslabel==nil)
        [cell setupcell];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    [cell.addresslabel setText:[self.addressArr[indexPath.section] objectForKey:@"address"]];
    [cell.phonelabel setText:[self.addressArr[indexPath.section] objectForKey:@"phone_num"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    EditAddrViewController *editvc=[[EditAddrViewController alloc]init];
    editvc.addrid=[NSString stringWithFormat:@"%@", [[self.addressArr objectAtIndex:indexPath.section]objectForKey:@"id"]];
    editvc.editAddress_arrindex = indexPath.section;
    AddressTableViewCell* editcell = [self.tableview cellForRowAtIndexPath:indexPath];
    editvc.addstr = editcell.addresslabel.text;
    editvc.phonestr = editcell.phonelabel.text;
    [self presentViewController:editvc animated:NO completion:nil];
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.canBeSelected) {
        NSMutableArray* selectedAddressDict = self.addressArr[indexPath.section];
        ConfirmTableViewController* confirmController = [[self.navigationController viewControllers] objectAtIndex:[self.navigationController.viewControllers count] -2];
        confirmController.defaultAddressDict = selectedAddressDict;
        [confirmController.table reloadData];
        [self.navigationController popViewControllerAnimated:YES];
}
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete){
         UIAlertView *deletealert = [[UIAlertView alloc] initWithTitle:nil
                                                message:@"确认删除收货地址？"
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"确定",nil];
        deleteIndexPath = indexPath;
        [deletealert show];
    }
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1){
        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//        //申明返回的结果是json类型
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        //申明请求的数据是json类型
//        manager.requestSerializer=[AFJSONRequestSerializer serializer];    //如果报接受类型不一致请替换一致text/html或别的
//        [manager.requestSerializer setValue:@"4244b7ac-4fbb-11e5-82bd-00163e021195"forHTTPHeaderField:@"access_token"];
        //[manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"]
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];

        NSString *url=[@"http://115.29.197.143:8999/v1.0/user/address/" stringByAppendingString:[NSString stringWithFormat:@"%@",[[self.addressArr objectAtIndex:deleteIndexPath.section] objectForKey:@"id"]]];
        
        [appdelegate.manager DELETE:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.addressArr removeObjectAtIndex:deleteIndexPath.section];
            [self.tableview deleteSections:[NSIndexSet indexSetWithIndex:deleteIndexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
