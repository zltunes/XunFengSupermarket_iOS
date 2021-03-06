//
//  OrderTableViewController.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/24.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderTableViewController.h"
#import "OrderEvaluate.h"
#import "detailedOrderStatusTableViewController.h"
#import "OrderAppDelegate.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "FastLoginViewController.h"

@interface OrderTableViewController ()
{
    //获取delegate对象，以访问manager属性
    OrderAppDelegate* appDelegate;
    //订单数组，数组元素为字典
    NSMutableArray* ordersArray;
    NSString* ordersURL;//获取所有订单
    int page_count;
}
@end

@implementation OrderTableViewController

- (void)viewDidLoad {
        appDelegate = [UIApplication sharedApplication].delegate;//为了访问manager属性
    [self initOrderView];
    }
-(void)initOrderView
{
    if (!appDelegate.islogin) {

        self.toregistOrloginlabel = [[UIImageView alloc]initWithFrame:CGRectMake(35,0.2*kWindowHeight , kWindowWidth-70, kWindowHeight*0.35)];
        self.toregistOrloginlabel.image = [UIImage imageNamed:@"weidenglu.png"];

        [self.table setHidden:YES];
        [self.view addSubview:self.toregistOrloginlabel];
    }
    else{//已登录
        self.table=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kWindowWidth, kWindowHeight-64)];
        self.table.delegate=self;
        self.table.dataSource=self;
        [self.view addSubview:self.table];
        
        
        //mjrefresh下拉刷新
        self.table.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        [self.table.header beginRefreshing];
        //mjrefresh上拉加载
        self.table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
        
        page_count = 1;
        ordersArray = [[NSMutableArray alloc]init];

    }

}
-(void)initOrderViewAfterLogin
{
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0,64,kWindowWidth, kWindowHeight-64)];
    self.table.delegate=self;
    self.table.dataSource=self;
    [self.view addSubview:self.table];
    
    
    //mjrefresh下拉刷新
    self.table.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.table.header beginRefreshing];
    //mjrefresh上拉加载
    self.table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    page_count = 1;
    ordersArray = [[NSMutableArray alloc]init];
}
-(void)toRegisterOrLogin
{
    FastLoginViewController *regvc=[[FastLoginViewController alloc]init];
    [self presentViewController:regvc animated:NO completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}
//下拉刷新
- (void)headerRefreshing
{
    //下拉永远获取的是page1订单
    ordersURL = @"http://115.29.197.143:8999/v1.0/orders";
    [appDelegate.manager GET:ordersURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取所有订单成功!");
        //将服务器json数据转化成NSArray,赋值给orders属性
        ordersArray = responseObject;
        page_count = 1;
        [self.table.header endRefreshing];
        [self.table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取所有订单失败: %@",error);
    }];
}
//上拉加载
-(void)footerRefreshing
{
    page_count += 1;
    NSDictionary* param = @{@"page":[NSNumber numberWithInt:page_count]};
    NSString* order_nextPage_URL = @"http://115.29.197.143:8999/v1.0/orders";
    [appDelegate.manager GET:order_nextPage_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray* newarr = responseObject;
        if ([newarr count]==1) {
            //意味着该页没有订单了，此处需要与后台商量，没有订单应该返回error!
            NSDictionary* dic = [newarr objectAtIndex:0];
            if ([[dic objectForKey:@"state"] isEqualToString:@"error"]) {
                [self.table.footer noticeNoMoreData];
                page_count -= 1;
            }
        }else{
        ordersArray = [ordersArray arrayByAddingObjectsFromArray:newarr];
        }
        [self.table reloadData];
        [self.table.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取第%d页10个订单失败！",page_count);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [ordersArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (OrderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//[{name,icon,time,total,state,id,sup_id}...]7
    static NSString* cellId = @"cellId";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary* orderdict = [ordersArray objectAtIndex:[ordersArray count]-indexPath.section-1];//每一个dict为一个订单
    //1⃣️订单状态
    NSString* status = [orderdict objectForKey:@"state"];
    if ([status isEqualToString:@"paid"]) {
        cell.OrderStatus = @"等待超市接单";
    } else if([status isEqualToString:@"accepted"]){
        cell.OrderStatus = @"配送中";
    }else if ([status isEqualToString:@"received"]){
        cell.OrderStatus = @"已送达";
    }else if ([status isEqualToString:@"successed"]){
        cell.OrderStatus = @"订单完成";
    }else if([status isEqualToString:@"canceled"]){
        cell.OrderStatus = @"已取消";
    }
    cell.statusLabel.text = cell.OrderStatus;
    //2⃣️订单id
    cell.orderID = [[orderdict objectForKey:@"id"] intValue];
    //7⃣️超市id
    cell.superID = [[orderdict objectForKey:@"sup_id"] intValue];
    //3⃣️超市名称
    cell.nameOfSupermarket.text = [orderdict objectForKey:@"name"];
    //4⃣️总价
    cell.priceLabel.text =[NSString stringWithFormat:@"¥ %@",[orderdict objectForKey:@"total"]];
    [cell.priceLabel sizeToFit];
    //5⃣️icon-－URL
    NSURL *icon_url = [NSURL URLWithString:[orderdict objectForKey:@"icon"]];
//    cell.img = [[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:icon_url]]];
//    cell.img = [[UIImageView alloc]init];
    [cell.img sd_setImageWithURL:icon_url placeholderImage:[UIImage imageNamed:@"supermarket.png"]];
    //6⃣️time
    cell.timeLabel.text = [orderdict objectForKey:@"time"];
    //依据订单状态确定按钮文字
    if ([cell.OrderStatus  isEqual: @"配送中"]) {
        cell.querenshouhuoBtn.hidden = NO;
        cell.pingjiaBtn.hidden = YES;
        cell.querenshouhuoBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer* ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(confirmStatusBtn:)];
        [cell.querenshouhuoBtn addGestureRecognizer:ges];
        ges.view.tag = cell.orderID;
    } else if([cell.OrderStatus isEqual:@"已送达"]){
        cell.querenshouhuoBtn.hidden = YES;
        cell.pingjiaBtn.hidden = NO;
        cell.pingjiaBtn.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(evaluateOrder:)];
        [cell.pingjiaBtn addGestureRecognizer:ges];
        ges.view.tag = indexPath.section;

    }else{
        cell.querenshouhuoBtn.hidden = YES;
        cell.pingjiaBtn.hidden = YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //获取被点击cell
    OrderTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    appDelegate.orderID = cell.orderID;
    appDelegate.superID = cell.superID;
    detailedOrderStatusTableViewController* detailedStatusController = [[detailedOrderStatusTableViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailedStatusController animated:YES];

    //设置下一页面的返回,即为超市名
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:cell.nameOfSupermarket.text  style:UIBarButtonItemStylePlain  target:self  action:nil];
//    self.navigationItem.backBarButtonItem = backButton;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)confirmStatusBtn:(UITapGestureRecognizer*)sender
{
    UITapGestureRecognizer* ges = sender;
    //确认收货/v1.0/user/order/{oid}-----此处用tag标记oid
    NSString* confirmReceived = [NSString stringWithFormat:@"http://115.29.197.143:8999/v1.0/user/order/%ld",(long)ges.view.tag];
    [appDelegate.manager PUT:confirmReceived parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"确认收货成功！");
        [self.table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"确认收货失败！%@",error);
    }];
}
-(void)evaluateOrder:(UITapGestureRecognizer*)sender
{
    UITapGestureRecognizer* ges = sender;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:[ges.view tag]];
    NSLog(@"点击评价后tag:%ld",[ges.view tag]);
    OrderTableViewCell* cell = [self.table cellForRowAtIndexPath:indexPath];
    //向评价页面传送order_id   super_id
    appDelegate.orderID = cell.orderID;
    appDelegate.superID = cell.superID;
    OrderEvaluate *evalueatController = [[OrderEvaluate alloc]init];
    [self.navigationController pushViewController:evalueatController animated:YES];
    //自定义返回按钮（将来换成图片）
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"评价"  style:UIBarButtonItemStylePlain  target:self  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

@end
