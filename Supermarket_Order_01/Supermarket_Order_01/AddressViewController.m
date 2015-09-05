//
//  AddressViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "NewAddrViewController.h"
#import "EditAddrViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
@interface AddressViewController (){
    int deleterow;
     NSArray *deletearray;
}

@end

@implementation AddressViewController
@synthesize navbar;
@synthesize navitem;
- (void)viewDidLoad {
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    self.datasource=[[NSMutableArray alloc]init];
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
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 86*[self.datasource count])];
    [self.tableview registerClass:[AddressTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.view addSubview:self.tableview];
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.addbtn=[[UIButton alloc]initWithFrame:CGRectMake(147.5, 225, 25, 25)];
    [self.view addSubview:self.addbtn];
    [self.addbtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.addbtn setBackgroundColor:[UIColor blueColor]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];    //如果报接受类型不一致请替换一致text/html或别的
    
    [manager.requestSerializer setValue:@"b07f18c8-3f14-11e5-82bd-00163e021195"forHTTPHeaderField:@"Access_token"];
    //[manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"]
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:@"http://115.29.197.143:8999/v1.0/user/addresses" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.datasource=responseObject;
            self.tableview.frame=CGRectMake(0, 70, self.view.bounds.size.width, 86*[self.datasource count]);
            [self.tableview reloadData];
        });
        
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程

    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

    // Do any additional setup after loading the view.
}
-(void)add{
    NewAddrViewController *newaddrvc=[[NewAddrViewController alloc]init];
    [self presentViewController:newaddrvc animated:NO completion:nil];
}

-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.datasource count];
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
    [cell.addresslabel setText:[self.datasource[indexPath.section] objectForKey:@"address"]];
    [cell.phonelabel setText:[self.datasource[indexPath.section] objectForKey:@"phone_num"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditAddrViewController *editvc=[[EditAddrViewController alloc]init];
    editvc.addrid=[NSString stringWithFormat:@"%@", [[self.datasource objectAtIndex:indexPath.row]objectForKey:@"id"]];
    [self presentViewController:editvc animated:NO completion:nil];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete){
    
        deleterow=indexPath.row;
        //  [arr removeObjectAtIndex:indexPath.row];
        //[arrImage removeObjectAtIndex:indexPath.row];
        
         UIAlertView *deletealert = [[UIAlertView alloc] initWithTitle:nil
                                                message:@"确认删除收货地址？"
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"确定",nil];
        [deletealert show];
        deletearray=@[indexPath];
        
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        
    }
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1){
            [self.tableview deleteRowsAtIndexPaths:deletearray withRowAnimation:UITableViewRowAnimationLeft];
    }
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
