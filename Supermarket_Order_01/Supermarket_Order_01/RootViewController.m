//
//  RootViewController.m
//  Final1
//
//  Created by 张悦心 on 15/7/7.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "RootViewController.h"
#import "Header.h"
#import "MarketCell.h"
#import "DetailViewController.h"
#import "AFtools.h"
#import "UIImageView+WebCache.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray *array;//存放字典的数组（字典里面存放条目详情）;
@property(strong,nonatomic)NSMutableArray *detailArray;//放marketarray
//@property(strong,nonatomic)NSMutableArray *marketArray;
@property(strong,nonatomic)UITableView *marketTableView;//显示的表格行

@property(nonatomic)UIImageView *marketImage;

@property (nonatomic)NSObject *result;//临时存放的Access token
@property (nonatomic)id result2;
@property (nonatomic)NSInteger marketCount;
@property (nonatomic)NSInteger flag;
//点击超市进入购买页面的后台url
@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置导航栏的背景颜色和字体颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self connectBackGround];

 }
-(void)viewWillDisappear:(BOOL)animated
{
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _marketCount = 0;
    _result2 = nil;
    //设置返回按钮的字
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    UITableView *marketTableView =[[UITableView alloc]initWithFrame:(CGRect){0,0,kWindowWidth,kWindowHeight}];
    marketTableView.rowHeight = 150;
    marketTableView.delegate = self;
    marketTableView.dataSource = self;
    marketTableView.hidden = YES;
    [self.view addSubview:marketTableView];
    _marketTableView = marketTableView;
    
    NSMutableArray *detailArray = [NSMutableArray array];
    _detailArray = detailArray;

    [self hideExcessLine:self.marketTableView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//array中有几个元素（几个超市）就有几个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _marketCount;
}
//创建超市单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketCell* cell = [[MarketCell alloc]init];

    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    cell.data = _result2[indexPath.row];
    return cell;
}
-(void)hideExcessLine:(UITableView *)tableView{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
}
//点击单元格进入超市详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row || indexPath.row==1) {
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    detailViewController.barName =[_result2[indexPath.row]objectForKey:@"name"];
    //获得超市id
    NSString *url = [NSString stringWithFormat:@"%@%@%@",@"http://115.29.197.143:8999/v1.0/supermarket/",self.result2[indexPath.row][@"id"],@"/goods"];
    //设置viewcontroaller的超市id和url
    detailViewController.marId = [self.result2[indexPath.row][@"id"]intValue];
    detailViewController.url = url;
    //设置搜索url
    url = [NSString stringWithFormat:@"%@%@%@",@"http://115.29.197.143:8999/v1.0/supermarket/",self.result2[indexPath.row][@"id"],@"/good"];
    detailViewController.urlSearch = url;
    [self setHidesBottomBarWhenPushed:YES]; 
    [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"商家休息中!" message:@"选择其他超市吧!" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self.marketTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)connectBackGround{
    NSString *url2 = @"http://115.29.197.143:8999/v1.0/supermarkets";

    NSDictionary *parameters3 = @{@"longitude":@"118.826079",@"latitude":@"31.893348"};
    
    [AFtools JSONDataWithUrl:url2 parameters:parameters3 HttpHeader:nil success:^(id responseObject){
        self.result2 = responseObject;
        self.marketCount = [_result2 count];
        [_marketTableView reloadData];
        _marketTableView.hidden = NO;
    } fail:^{
        NSLog(@"获取附近超市列表失败!");
    }];
}

@end
