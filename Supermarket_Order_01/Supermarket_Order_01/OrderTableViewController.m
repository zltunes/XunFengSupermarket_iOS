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

@interface OrderTableViewController ()
{
    //获取delegate对象，以访问manager属性
    OrderAppDelegate* appDelegate;
    //指定接口地址
    NSString* orderURL;
    //后台获取的该用户所有订单
    NSArray* orders;
}
@end

@implementation OrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订 单";
    appDelegate = [UIApplication sharedApplication].delegate;//为了访问manager属性
    orderURL = @"http://115.29.197.143:8999/v1.0/orders";
    
    //使用manager发送get请求,更新用户订单列表
//    NSDictionary* param = @{@"page":@1};
    /*
    [appDelegate.manager GET:orderURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将服务器json数据转化成NSArray,赋值给orders属性
        orders = responseObject;
        [self.tableView reloadData];
        NSLog(@"连接后台成功!");
        NSLog(@"用户订单个数：%lu",(unsigned long)[orders count]);
        for (int i = 0; i < [orders count]; i++) {
            NSDictionary* dict = [orders objectAtIndex:i];
            NSLog(@"超市名称:%@",[dict objectForKey:@"sup_name"]);
        }
        //重新加载表格数据
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取订单信息有误: %@",error);
    }];
     */
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.tableView reloadData];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 5;
//    return [orders count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (OrderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取订单，存储为dict
//    NSDictionary* dict = [orders objectAtIndex:indexPath.section];
    //{sup_name,state,total,icon,time}
    static NSString* cellId = @"cellId";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //订单状态(本地)
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"OrderStatus" ofType:@"plist"];
    NSArray* statusArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    //2⃣️订单状态
//    cell.OrderStatus = [dict objectForKey:@"state"];
    cell.OrderStatus = [statusArray objectAtIndex:indexPath.section];
    cell.statusLabel.text = cell.OrderStatus;
    //1⃣️超市名称
//    cell.nameOfSupermarket.text = [dict objectForKey:@"sup_name"];
    //3⃣️总价
//    cell.priceLabel.text = [dict objectForKey:@"total"];
    //4⃣️icon-－URL
//    NSURL *icon_url = [NSURL URLWithString:[dict objectForKey:@"icon"]];
//    cell.img = [[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:icon_url]]];
    //5⃣️time
//    cell.timeLabel.text = [dict objectForKey:@"time"];
    //依据订单状态确定按钮文字
    if ([cell.OrderStatus  isEqual: @"配送中"]) {
        cell.querenshouhuoBtn.hidden = NO;
        cell.querenshouhuoBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer* ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(confirmStatusBtn:)];
        [cell.querenshouhuoBtn addGestureRecognizer:ges];
    } else if([cell.OrderStatus isEqual:@"已送达"]){
        cell.pingjiaBtn.hidden = NO;
        cell.pingjiaBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer* ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(evaluateOrder:)];
        [cell.pingjiaBtn addGestureRecognizer:ges];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //获取被点击cell
    OrderTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    detailedOrderStatusTableViewController* detailedStatusController = [[detailedOrderStatusTableViewController alloc]init];
    appDelegate.orderID = [NSNumber numberWithLong:indexPath.section];
 
    [self.navigationController pushViewController:detailedStatusController animated:YES];
    
    //设置下一页面的返回,即为超市名
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:cell.nameOfSupermarket.text  style:UIBarButtonItemStylePlain  target:self  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

-(void)confirmStatusBtn:(UIButton*)sender
{
    //处理：点击“确认收货”后向后台发送数据，后台更改订单状态，然后[self.table reloadData]刷新tableview
//    sender.hidden = YES;
    NSLog(@"querenshouhuoBtn");
    /*
     ？？？？？？？？？？？？？？？？？？？？
     此处api还在修改，如何向后台修改订单状态？
     */
}
-(void)evaluateOrder:(UIButton*)sender
{
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
