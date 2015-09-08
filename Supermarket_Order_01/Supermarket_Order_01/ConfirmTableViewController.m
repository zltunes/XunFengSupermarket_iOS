//
//  ConfirmTableViewController.m
//  OrderConfirm
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "ConfirmTableViewController.h"
#import "AddressInfoCell.h"
#import "RemarkCell.h"
#import "Header.h"
#import "OrderPayViewController.h"
#import "OrderAppDelegate.h"
#import "purchaseBagCell.h"

@interface ConfirmTableViewController ()
{
    OrderAppDelegate *delegate;
    NSString* orderCreateURL;
    NSString* start_timeURL;
    NSString* remark;//备注
    RemarkCell* remarkCell;
    NSMutableArray* goods;//后台传送
    NSMutableArray* purchaseBag;//界面购物袋
    int start_time_id;//起送时间
    int goodcount;
    float packPrice;
    float sendPrice;
}

@end

@implementation ConfirmTableViewController
-(void)viewDidLoad
{
    //初始默认值
    sendPrice = 0.5;
    packPrice = 0.0;
    goodcount = 0;
    self.topayPrice = packPrice + sendPrice +self.totalGoodsPrice;
    remark = @"我的备注";
    self.start_timeStringArr = [[NSMutableArray alloc]init];
    self.start_timeIDArr = [[NSMutableArray alloc]init];
    self.timearr = [[NSMutableArray alloc]init];
    delegate = [UIApplication sharedApplication].delegate;
    NSString* timeurl1 = [NSString stringWithFormat:@"http://115.29.197.143:8999/v1.0/supermarket/%d",self.sup_id];
    NSString* timeurl2 = @"/times";
    start_timeURL = [timeurl1 stringByAppendingString:timeurl2];
    orderCreateURL = @"http://115.29.197.143:8999/v1.0/order";
    
    purchaseBag = [[NSMutableArray alloc]init];
    goods = [[NSMutableArray alloc]init];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight-45)];
    [self hideExcessLine:self.table];
    self.table.dataSource = self;
    self.table.delegate = self;
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,kWindowHeight-45,kWindowWidth, 45)];
    self.bottomView.backgroundColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    self.goodsCount = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWindowWidth/4, 45)];
    self.totalPricelabel = [[UILabel alloc]initWithFrame:CGRectMake(10+kWindowWidth/4, 0, kWindowWidth/4, 45)];
    self.totalPricelabel.textColor = [UIColor orangeColor];
    self.totalPricelabel.text = [NSString stringWithFormat:@"￥ %g",self.topayPrice];
    self.totalPricelabel.font = [UIFont boldSystemFontOfSize:18.0];

    UIImage* quxiadanimg = [[UIImage imageNamed:@"quxiadan.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn4.frame = CGRectMake(0.8*kWindowWidth,10, 55, 27);
    [self.btn4 setImage:quxiadanimg forState:UIControlStateNormal];
    self.btn4.userInteractionEnabled = YES;
    UITapGestureRecognizer* quxiadan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
    [self.btn4 addGestureRecognizer:quxiadan];
    [self.bottomView addSubview:self.goodsCount];
    [self.bottomView addSubview:self.totalPricelabel];
    [self.bottomView addSubview:self.btn4];
    [self.view addSubview:self.table];
    [self.view addSubview:self.bottomView];
    
    [delegate.manager GET:start_timeURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取start_time成功!start_time个数: %lu",(unsigned long)[responseObject count]);
        self.timearr = responseObject;
        for (int i = 0; i<[self.timearr count]; i++) {
            NSString* timestr = [[self.timearr objectAtIndex:i] objectForKey:@"time"];
            self.start_timeStringArr = [self.start_timeStringArr arrayByAddingObject:timestr];
            self.start_timeIDArr = [self.start_timeIDArr arrayByAddingObject:[[self.timearr objectAtIndex:i] objectForKey:@"id"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取start_time失败:%@",error);
    }];
    for (int i=0; i<[self.goodsArr count]; i++) {
        NSDictionary* dict = [self.goodsArr objectAtIndex:i];
        NSDictionary* dict1 = @{@"name":[dict objectForKey:@"name"],@"quantity":[dict objectForKey:@"quantity"],@"price":[dict objectForKey:@"price"]};
        NSDictionary* dict2 = @{@"gid":[dict objectForKey:@"gid"],@"quantity":[NSNumber numberWithInt:[[dict objectForKey:@"quantity"]intValue]]};
        purchaseBag = [purchaseBag arrayByAddingObject:dict1];
        goods = [goods arrayByAddingObject:dict2];
    }
    for (int i = 0; i<[goods count]; i++) {
        goodcount += [goods[i][@"quantity"] intValue];
    }
    self.goodsCount.text = [NSString stringWithFormat:@"%d  份",goodcount];
    [super viewDidLoad];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat heightForHeader = 15;
    switch (section) {
        case 3:
            heightForHeader = 45;
            break;
        default:
            heightForHeader = 15;
            break;
    }
    return heightForHeader;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 1;
    // Return the number of rows in the section.
    switch (section) {
        case 3:
            rows = [self.goodsArr count];//需看后台数据，即用户购买商品数量
            break;
        case 4:
            rows = 2;
            break;
        default:
            rows = 1;
            break;
    }
    return  rows;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* headerForSection3 = @"购物袋";
    if (section == 3) {
        return headerForSection3;
    }
    else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cell0 = @"cell0";
    static NSString* cell1 = @"cell1";
    static NSString* cell2 = @"cell2";
    static NSString* cell3 = @"cell3";
    static NSString* cell4 = @"cell4";
    UITableViewCell *cell;
    NSInteger rowNo = indexPath.row;
    //包装费\配送费

    //plist模拟商品
    /*
     以下均为本地模拟，实际从上一界面获取
     */
//    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"购物袋" ofType:@"plist"];
//    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    NSArray* goods = dict[@"goods"];
    
    if (indexPath.section == 0) {
        //收货地址及电话
        cell = [tableView dequeueReusableCellWithIdentifier:cell0];
        if (!cell) {
            cell = [[AddressInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell0];
        }
        return  cell;
    }
    else if (indexPath.section == 1){
        //起送时间
        cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell1];
            cell.textLabel.text = @"起送时间";//名称应和plistname相同
            cell.detailTextLabel.text = @"点击选择";
        }
        return cell;
    }
    else if (indexPath.section == 2){
        //备注
        remarkCell = [tableView dequeueReusableCellWithIdentifier:cell2];
        if (!remarkCell) {
            remarkCell = [[RemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
        return remarkCell;
    }
    else if(indexPath.section == 3){
        //购物袋
        purchaseBagCell* purchaseCell;
        purchaseCell = [tableView dequeueReusableCellWithIdentifier:cell3];
        if (!purchaseCell) {
            purchaseCell = [[purchaseBagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3];
        }
        //plist模拟商品,实际要从上一界面获取
        purchaseCell.goodsNameLabel.text = [[purchaseBag objectAtIndex:rowNo] objectForKey:@"name"];
        purchaseCell.goodsCountLabel.text = [NSString stringWithFormat:@"%@",[[purchaseBag objectAtIndex:rowNo] objectForKey:@"quantity"]];
        purchaseCell.totalPriceLabel.text = [NSString stringWithFormat:@"%@",[[purchaseBag objectAtIndex:rowNo]objectForKey:@"price"]];
        return purchaseCell;
    }
    else{
        //包装配送费
        cell = [tableView dequeueReusableCellWithIdentifier:cell4];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell4];
        }
        if (!rowNo) {
            //包装费
            cell.textLabel.text = @"包装费";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%g",packPrice];
        }
        if (rowNo == 1){
            cell.textLabel.text = @"配送费";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%g",sendPrice];
        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:
            height = 75.0;
            break;
        case 1:
            height = 38;
            break;
        case 2:
            height = 38;
            break;
        default:
            height = 40.5;
            break;
    }
    return height;
}
//tableViewCell点击事件设定
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    //section1点击时弹出ZHPicker
    if (indexPath.section == 1) {
        _indexPath=indexPath;
        [_pickview remove];
        UITableViewCell * cell=[self.table cellForRowAtIndexPath:indexPath];//获取当前cell,为其制定picker
        _pickview=[[ZHPickView alloc] initPickviewWithPlistName:cell.textLabel.text isHaveNavControler:NO];
        _pickview.delegate=self;
        [_pickview show];
    }
}
/*
 start_time_id
 */
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    UITableViewCell* cell=[self.table cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text=resultString;
    //根据resultString获取对应的start_time_id
    for (int i = 0; i < [self.timearr count]; i++) {
        if ([resultString isEqualToString:[self.start_timeStringArr objectAtIndex:i]]) {
            start_time_id = [[self.start_timeIDArr objectAtIndex:i] intValue];
            break;
        }
    }
}
//点击“去下单”按钮,先向后台创建order，再跳转到支付界面
-(void)clicked:(id)sender
{
    //创建order给后台
    /*
     post参数
     {adr_id,start_time,remark,cou_id，sup_id,
     goods:[{gid,quantity},…]}
     返回：
     ord_id
     */
    NSNumber* adr_id = [NSNumber numberWithInt:10];//跳转到“我的地址”界面后进行选择的地址
    //问题！！
    NSNumber* cou_id = [NSNumber numberWithInt:1];//我拥有的该超市的coupon，这个应该下一界面支付的时候再用
    remark = remarkCell.remarkField.text;
    NSNumber* sup_id = [NSNumber numberWithInt:self.sup_id];

    //创建订单
    NSDictionary* param = @{@"adr_id":adr_id,@"start_time_id":[NSNumber numberWithInt:start_time_id],@"remark":remark,@"cou_id":cou_id,@"sup_id":sup_id,@"goods":goods};
    [delegate.manager POST:orderCreateURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.order_id = [[responseObject objectForKey:@"ord_id"] intValue];
        NSLog(@"创建订单成功，返回order_id!%d",self.order_id);
        //跳转到支付界面
        OrderPayViewController* payViewController = [[OrderPayViewController alloc]init];
        payViewController.totalPrice = self.topayPrice;
        payViewController.order_id = self.order_id;
        [self.navigationController pushViewController:payViewController animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"创建订单失败：%@",error);
    }];
}
@end
