//
//  OrderPayViewController.m
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/26.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderPayViewController.h"
#import "Header.h"
#import "OrderAppDelegate.h"

#import "detailedOrderStatusTableViewController.h"

@interface OrderPayViewController ()
{
    OrderAppDelegate* delegate;
    NSString* couponsURL;
    NSString* deleteOrderURL;
    NSString* myBalanceURL;//账户余额
    NSArray* couponsArray;
    NSArray* couponsIDarr;//购物券id
    UIPopoverListView* popListView;
}
@end

@implementation OrderPayViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = [UIApplication sharedApplication].delegate;
    couponsURL = @"http://115.29.197.143:8999/v1.0/coupons";
    //[{id,price,state,timelimit}]
    myBalanceURL = @"http://115.29.197.143:8999/v1.0/user";
    [delegate.manager GET:myBalanceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取我的信息成功!余额:%@",[responseObject objectForKey:@"balance"]);
        NSDictionary* mydic = responseObject;
        self.banlance = [[mydic objectForKey:@"balance"]floatValue];
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取账户余额失败!%@",error);
    }];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight-100) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self hideExcessLine:self.table];
    [self.view addSubview:self.table];
    self.lastIndexPath = nil;
    
    //自定义返回按钮及事件,将来换成图片
    UIBarButtonItem* customBackBatButton = [[UIBarButtonItem alloc]initWithTitle:@"< 订单支付" style:UIBarButtonItemStylePlain target:self action:@selector(returnToOrderConfirm:)];
    customBackBatButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = customBackBatButton;
    
    
    //btn将来换成图片,btn处理有三步：
    //1⃣️btn type
    self.confirmPayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //2⃣️btn 位置
    self.confirmPayBtn.frame = CGRectMake(20, 0.85*kWindowHeight, kWindowWidth-40, 45);
    //3⃣️btn 背景图片
    UIImage* img = [UIImage imageNamed:@"querenzhifu.png"];
    [self.confirmPayBtn setBackgroundImage:img forState:UIControlStateNormal];
    //4⃣️btn 事件
    [self.confirmPayBtn addTarget:self action:@selector(toPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmPayBtn];
}

//自定义左边返回按钮事件
-(void)returnToOrderConfirm:(id)sender
{
    UIAlertView* alert1 = [[UIAlertView alloc]initWithTitle:@"是否放弃付款?" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    alert1.tag = 1;
    [alert1 show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //点击“是”放弃付款返回上一页面并取消该订单（用户自己取消）
    if (buttonIndex) {
        deleteOrderURL = [NSString stringWithFormat:@"http://115.29.197.143:8999/v1.0/user/order/%d",self.order_id];
        [delegate.manager DELETE:deleteOrderURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"拒绝支付,取消订单成功！");
            [self.navigationController popViewControllerAnimated:self];
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"拒绝支付，取消订单失败!%@",error);
        }];
    }
}

-(void)hideExcessLine:(UITableView *)tableView{
    
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cell0 = @"cell0";
    static NSString* cell1 = @"cell1";
    UITableViewCell* cell;
    NSInteger rowNo = indexPath.row;
    //plist模拟支付
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"订单支付" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSMutableArray* left = dict[@"payleft"];
    if (!indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:cell0];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell0];
            if (!rowNo) {
                //订单总价
                cell.textLabel.text = [left objectAtIndex:rowNo];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%g 元",self.totalPrice];
            }else if (rowNo == 2){
                //我的余额
                cell.textLabel.text = [left objectAtIndex:1];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%g 元",self.banlance];
                //从后台获取账户余额
                //u_id,authority,balance,phone_num

            }else if (rowNo == 3){
                //还需支付
                //需要判断是不是首次下单
                cell.textLabel.text = [left objectAtIndex:2];
                
                //从orderTableViewControler的ordersArray获取数量
                
                
            
                self.toPayValue = self.totalPrice - self.couponCount - self.banlance;
                if (self.toPayValue < 0) {
                    self.toPayValue = 0;
                }
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%g 元",self.toPayValue];
                cell.detailTextLabel.textColor = [UIColor orangeColor];
            }else if (rowNo ==1){
                //优惠券
                if (self.couponCount) {
                    cell.textLabel.text = [NSString stringWithFormat:@"%d 元购物券",self.couponCount];
                }
                else{
                cell.textLabel.text = @"我的购物券";
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.couponCell = cell;
            }
        }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell1];
            if (!rowNo) {
                cell.imageView.image = [UIImage imageNamed:@"zhifubao.png"];
                cell.textLabel.text = @"支付宝支付";
                cell.detailTextLabel.text = @"推荐有支付宝账户的用户使用";
                cell.detailTextLabel.textColor = [UIColor grayColor];
            } else {
                cell.imageView.image = [UIImage imageNamed:@"weixin.jpeg"];
                cell.textLabel.text = @"微信支付";
                cell.detailTextLabel.text = @"推荐安装微信5.0及以上版本的用户使用";
                cell.detailTextLabel.textColor = [UIColor grayColor];
            }
        }
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if (!section) {
        num = 4;
    }
    else{
        num = 2;
    }
    return num;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 1){
        height = 55;
    }
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = 53;
    if (indexPath.section) {
        height = 72;
    }
    return  height;
}
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* header = nil;
    if (section == 1) {
        header = @"选择支付方式";
    }
    return header;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //section0:row1被点击后选择购物券
    if (indexPath.section == 0) {
        if(indexPath.row == 1){
            //获取购物券张数
            [delegate.manager GET:couponsURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"获取购物券成功!购物券张数:%lu",(unsigned long)[responseObject count]);
                couponsArray = [[NSArray alloc]initWithArray:responseObject];
                CGFloat xWidth = self.view.bounds.size.width - 40.0f;
                CGFloat yHeight = 180.0f;
                CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
                popListView = [[UIPopoverListView alloc]initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
                popListView.delegate = self;
                popListView.datasource = self;
                [popListView setTitle:@"选择优惠券"];
                [popListView show];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"获取购物券失败!%@",error);
            }];
        self.couponCount = 0;//选择购物券前购物券先清零
        }
    }
    //section1:选择支付方式
    else{
        UITableViewCell *cell = [self.table cellForRowAtIndexPath: indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryNone){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        if (self.lastIndexPath != nil && self.lastIndexPath != indexPath) {
            UITableViewCell* lastCell = [self.table cellForRowAtIndexPath:self.lastIndexPath];
            if (lastCell.accessoryType == UITableViewCellAccessoryCheckmark) {
                lastCell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        self.lastIndexPath = indexPath;
    }
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
}

//以下函数为实现UIPopoverListView协议
- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                       reuseIdentifier:identifier];
    NSDictionary* dict = [couponsArray objectAtIndex:row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dict[@"price"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"有效期至%@",dict[@"timelimit"]];
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [couponsArray count];
}

- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [self popoverListView:popoverListView cellForIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.couponCount = [cell.textLabel.text intValue];
    [self.table reloadData];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

//去付款
-(void)toPay:(id)sender
{
    UIAlertView* payAlertView = [[UIAlertView alloc]initWithTitle:@"支付成功！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    UIAlertView* warning = [[UIAlertView alloc]initWithTitle:@"至少选择一种支付方式！" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath* indexPath2 = [NSIndexPath indexPathForRow:1 inSection:1];
    UITableViewCell* chosePayCell1 = [self.table cellForRowAtIndexPath:indexPath1];
    UITableViewCell* chosePayCell2 = [self.table cellForRowAtIndexPath:indexPath2];
    //两种支付方式必须选一种
    if (!((chosePayCell1.accessoryType == UITableViewCellAccessoryNone) && (chosePayCell2.accessoryType == UITableViewCellAccessoryNone))){
        //创建订单支付信息
//        /v1.0/order/{o_id}/pay
        NSString* payURL1 =
        [NSString stringWithFormat:@"http://115.29.197.143:8999/v1.0/order/%d",self.order_id];
        NSString* payURL2 = @"/pay";
        self.payURL = [payURL1 stringByAppendingString:payURL2];
        
//        UIAlertView* alert2 = [[UIAlertView alloc]initWithTitle:@"登录" message:@"请输入支付账号与密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alert2.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//        [alert2 textFieldAtIndex:1].keyboardType = UIKeyboardTypeNumberPad;
//        alert2.tag = 2;
//        [alert2 show];
//        
        
        [delegate.manager POST:self.payURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            delegate.orderID = self.order_id;
            detailedOrderStatusTableViewController* detailView = [[detailedOrderStatusTableViewController alloc]init];
            detailView.PraiseFlag = 1;
            [self.navigationController pushViewController:detailView animated:YES];
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"支付失败:%@",error);
        }];
    }else{
        [warning show];
    }
}

@end
