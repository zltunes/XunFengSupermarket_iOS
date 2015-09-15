//
//  DetailViewController.m
//  Final1
//
//  Created by 张悦心 on 15/7/7.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "DetailViewController.h"
#import "leftTableViewCell.h"
#import "rightTableViewCell.h"
#import "MarketDetailVC.h"
#import "ClickDetailVC.h"
#import "BigDetail.h"
#import "Header.h"
#import "AFtools.h"
#import "SearchVC.h"
#import "ShoppingCarView.h"
#import "ConfirmTableViewController.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,BigDetailDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,ShoppingCarViewDelegate>
@property (strong,nonatomic)UITableView *leftTableView;
@property (strong,nonatomic)UITableView *rightTableView;
@property  NSMutableArray *temp;//右边表格项的临时数组
//下面的整体
@property (strong,nonatomic)UIView *bottomLabel;
//购物车图片
@property (nonatomic)UIImageView *carImage;
//购物车数量
@property (nonatomic)UILabel *goodsNumLabel;
//购物车黑背景
@property (nonatomic)UIView *carBackView;
@property (nonatomic)ShoppingCarView *shoppingCar;
@property (nonatomic)UILabel *totalPrice;//总价的label
@property UIButton *payBtn;
//左边栏前一个cell的路径
@property (nonatomic) NSIndexPath *leftpath;
//右边cell的path和临时的cell
@property (nonatomic)NSIndexPath *rightpath;
@property (nonatomic)rightTableViewCell *tempCell;
//右侧点击每个商品的界面（初始化为透明）
@property (nonatomic)BigDetail *bigDetail;
@property (nonatomic)UIView *backView;
//nsmuldic 存商品类名称
@property (nonatomic)NSMutableArray *nameArray;
@property (nonatomic)NSMutableDictionary *goodsDic;
//搜索条
@property (nonatomic)UISearchController *searchCtrl;
@property (nonatomic)UISearchBar *searchBar;
//跟搜索有关的变量
@property (nonatomic)NSMutableDictionary *searchParameters;
@property (nonatomic)NSMutableArray *searchGoods;
//给赵磊交互的array
@property (nonatomic)NSMutableArray *toZL;
@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    self.title = _barName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏背景颜色
    //[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //导航栏左右按钮颜色
//    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
//    //导航栏标题字体颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    
    [self connectBackGround];
    //返回按钮的事件
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UITableView *leftTableView = [[UITableView alloc]initWithFrame:(CGRect){0,0,kWindowWidth*0.3,kWindowHeight}];
    leftTableView.rowHeight = 50;
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    [self.view addSubview:leftTableView];
    leftTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _leftTableView = leftTableView;
    
    UITableView *rightTableView = [[UITableView alloc]initWithFrame:(CGRect){CGRectGetMaxX(leftTableView.frame)+10,CGRectGetMinY(leftTableView.frame)+65,kWindowWidth-10-(leftTableView.frame.size.width),kWindowHeight}];
    rightTableView.rowHeight = 90;
    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    [self.view addSubview:rightTableView];
    rightTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _rightTableView = rightTableView;
    
    
    
    UIView *bottomLabel = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowHeight-50, kWindowWidth, 50)];
    bottomLabel.backgroundColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    bottomLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *bottomAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomAction)];
    [bottomLabel addGestureRecognizer:bottomAction];
    [self.view addSubview:bottomLabel];
    _bottomLabel = bottomLabel;
    
    
    //注意这里的初始化坐标！！如果加到一个view上面，坐标时以父view为基准的坐标！！！
    UILabel *totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(75, 15, 50, 15)];
    totalPrice.text = @"0.0";
    totalPrice.font = [UIFont boldSystemFontOfSize:18];
    totalPrice.textColor = [UIColor colorWithRed:255.0/255 green:117.0/255 blue:68.0/255 alpha:1];
    totalPrice.textAlignment = NSTextAlignmentCenter;
    //totalPrice.layer.masksToBounds = YES;
    [bottomLabel addSubview:totalPrice];
    _totalPrice = totalPrice;
    
    UIImage *btnImage = [UIImage imageNamed:@"11.png"];
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    payBtn.frame = CGRectMake(bottomLabel.frame.size.width-100, 0, 80, 45);
    [payBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
    [bottomLabel addSubview:payBtn];
    _payBtn = payBtn;
    
    //购物车
    UIImageView *carImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, kWindowHeight-65, 50, 50)];
    carImage.image = [UIImage imageNamed:@"6.png"];
    carImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *carImageAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(carImageAction)];
    [carImage addGestureRecognizer:carImageAction];
    [self.view addSubview:carImage];
    _carImage = carImage;
    
    //购物车的数量显示
    UILabel *goodsNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(carImage.frame)-13,CGRectGetMinY(carImage.frame), 12, 12)];
    goodsNumLabel.backgroundColor = [UIColor redColor];
    goodsNumLabel.layer.cornerRadius = 6;
    goodsNumLabel.layer.masksToBounds = YES;
    goodsNumLabel.textColor = [UIColor whiteColor];
    goodsNumLabel.font = [UIFont boldSystemFontOfSize:10];
    goodsNumLabel.text = @"0";
    goodsNumLabel.textAlignment = NSTextAlignmentCenter;
    goodsNumLabel.hidden = YES;
    [self.view addSubview:goodsNumLabel];
    _goodsNumLabel = goodsNumLabel;
    
    
    UIImageView *moneyPic = [[UIImageView alloc]initWithFrame:CGRectMake(totalPrice.frame.origin.x-8,totalPrice.frame.origin.y, 15, 15)];
    moneyPic.image = [UIImage imageNamed:@"9.png"];
    [bottomLabel addSubview:moneyPic];
    
    
     //导航栏右边的超市详情按钮
    UIBarButtonItem *detailButton = [[UIBarButtonItem alloc] initWithTitle:@"超市详情" style:UIBarButtonItemStylePlain target:self action:@selector(touchDetail)];
    detailButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = detailButton;
    
    //searchBar搜索条
    UISearchController *searchCtrl = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchCtrl.searchBar.frame = CGRectMake(CGRectGetMaxX(leftTableView.frame)+10, CGRectGetMinY(rightTableView.frame)-30, CGRectGetWidth(rightTableView.frame), 30);
    searchCtrl.searchBar.placeholder = @"请输入商品名称";
    [searchCtrl.searchBar showsCancelButton];
    searchCtrl.dimsBackgroundDuringPresentation = NO;
    searchCtrl.searchResultsUpdater = self;
    searchCtrl.searchBar.delegate = self;
    searchCtrl.hidesNavigationBarDuringPresentation = NO;
    rightTableView.tableHeaderView = searchCtrl.searchBar;//把右边的tableview的hearderview设置成搜索条
    _searchCtrl = searchCtrl;
    _searchBar = searchCtrl.searchBar;
    
    NSMutableDictionary *searchParameters = [[NSMutableDictionary alloc]init];
    [searchParameters setObject:@" " forKey:@"key_word"];
    _searchParameters = searchParameters;
    
    
    //点击商品弹出的界面详情（一个黑色半透明view 一个自写的内容view）
    
    UIView *backView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.4;
    backView.hidden = YES;
    [self.view addSubview:backView];
    _backView = backView;
    
    BigDetail *bigDetail = [[BigDetail alloc]initWithFrame:CGRectMake(kWindowWidth*0.1,kWindowHeight*0.15, kWindowWidth*0.8, kWindowHeight*0.6)];
    bigDetail.hidden = YES;
    bigDetail.delegate = self;
    [self.view addSubview:bigDetail];
    _bigDetail = bigDetail;
    
    //购物车的黑色背景
    UIView *carBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight-bottomLabel.frame.size.height)];
    carBackView.backgroundColor = [UIColor blackColor];
    carBackView.alpha = 0.4;
    carBackView.hidden = YES;
    [self.view addSubview:carBackView];
    _carBackView = carBackView;
    
    //点击购物车view
    ShoppingCarView *shoppingCar = [[ShoppingCarView alloc]init];
    shoppingCar.hidden = YES;
    [self.view addSubview:shoppingCar];
    _shoppingCar = shoppingCar;
    
    //右边的表格的临时的array
    NSMutableArray *temp = [NSMutableArray array];
    _temp = temp;
    _temp = [_goodsDic objectForKey:_nameArray[0]];
    
    [_rightTableView reloadData];
    //给赵磊的array初始化
    NSMutableArray *toZL = [[NSMutableArray alloc]init];
    _toZL = toZL;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if(tableView == _leftTableView){
        return _nameArray.count;}
    else if (self.searchCtrl.active){
        return [_searchGoods count];
    }
    else{
        return _temp.count;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _leftTableView){
//        static NSString* cellId = @"cellId";
//        leftTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        
//        if(cell == nil){
//            cell = [[leftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        }
        leftTableViewCell* cell = [[leftTableViewCell alloc]init];
        cell.name = _nameArray[indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];


        return cell;
    }
    else if (self.searchCtrl.active){

        rightTableViewCell* cell = [[rightTableViewCell alloc]init];
        cell.zL = self.toZL;

        cell.data = _searchGoods[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.bottomPriceLabel = _totalPrice;
        return cell;

    }
    else{

        rightTableViewCell* cell = [[rightTableViewCell alloc]init];
        //右边表格的数据
        cell.zL = self.toZL;

        cell.data = _temp[indexPath.row];
                //取消选中状态
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //
        cell.bottomPriceLabel = _totalPrice;
        cell.carNum = _goodsNumLabel;
        
        return  cell;
    }
}


- (void)setMarketDeArray:(NSMutableArray *)marketDeArray{
    _marketDeArray = marketDeArray;
}

//表各项点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _leftTableView){
        [self searchBarCancelButtonClicked:self.searchCtrl.searchBar];
        if(_leftpath != nil){
            leftTableViewCell *cell1 = (leftTableViewCell *)[tableView cellForRowAtIndexPath:_leftpath];
            cell1.view1.hidden = YES;
            cell1.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
            cell1.nameText.textColor = [UIColor blackColor];
        }
        self.searchCtrl.active = NO;
        leftTableViewCell *cell = (leftTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.view1.hidden = NO;
        cell.backgroundColor = [UIColor whiteColor];
        cell.nameText.textColor = [UIColor colorWithRed:255.0/255 green:127.0/255 blue:0.0/255 alpha:1];
        
        _temp = [_goodsDic objectForKey:_nameArray[indexPath.row]];
        
        self.searchCtrl.active = NO;
        [_rightTableView reloadData];
        _leftpath = indexPath;
    }
    if(tableView == _rightTableView){
        self.searchCtrl.searchBar.hidden = YES;
        
        _rightpath = indexPath;
        rightTableViewCell * cell1 = (rightTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        _tempCell = cell1;
        
       [self bigDetailInit];
    }
}

- (void)didSelect:(id)sender{
    if([_totalPrice.text isEqualToString:@"0.0"]){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"至少选购一款商品!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    self.searchCtrl.active = NO;
    ConfirmTableViewController* confirmOrderViewController = [[ConfirmTableViewController alloc]init];
    confirmOrderViewController.sup_id = self.marId;
    confirmOrderViewController.totalGoodsPrice = [self.totalPrice.text floatValue];
    confirmOrderViewController.goodsArr = self.toZL;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:confirmOrderViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//当界面返回时清空购物车
- (void)viewWillDisappear:(BOOL)animated{
    [self clearShoppingCar];
}


//清空购物车方法
- (void)clearShoppingCar{
    for(int i = 0 ; i < _marketDeArray.count ; i ++){
        for (int m = 0; m < [[_marketDeArray[i] objectForKey:@"rightarray"] count]; m++) {
            [[_marketDeArray[i] objectForKey:@"rightarray"][m]setObject:@"0" forKey:@"num"];
        }
    }
}
//超市详情按钮事件
- (void)touchDetail{
    MarketDetailVC *marketVC = [[MarketDetailVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:marketVC animated:YES];
    marketVC.marId = self.marId;
    
}

//searchBar搜索条的代理函数实现
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchParameters setObject:searchBar.text forKey:@"key_word"];
    [AFtools JSONDataWithUrl:self.urlSearch parameters:_searchParameters HttpHeader:nil success:^(id responseObject){
        NSLog(@"ok");
        self.searchGoods = responseObject;
        NSLog(@"%lu",(unsigned long)[self.searchGoods count]);
        for(int i=0;i<[self.searchGoods count];i++){
            [self.searchGoods[i] setValue:@"0" forKey:@"num"];
        }
        [self.rightTableView reloadData];
        
    } fail:^{
        NSLog(@"error");
    }];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchCtrl.active = NO;
    for(int i=0;i<[_searchGoods count];i++){
        NSString *key = [_searchGoods[i]objectForKey:@"catalog"];//所在类目（左侧列表名）
        for(int m=0;m< [[_goodsDic objectForKey:key]count];m++){
            if([[[_goodsDic objectForKey:key][m]objectForKey:@"id"] isEqual:[_searchGoods[i]objectForKey:@"id"]]){
                [[_goodsDic objectForKey:key][m]setObject:[_searchGoods[i]objectForKey:@"num"] forKey:@"num"];
               // NSLog(@"%@",[[_goodsDic objectForKey:key][m]objectForKey:@"id"]);
            }
            
        }
    }
    [self.rightTableView reloadData];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
}

//与后台连接的函数
- (void)connectBackGround{
       [AFtools JSONDataWithUrl:self.url parameters:nil HttpHeader:nil success:^(id responseObject){
        NSLog(@"ok");
           self.goodsDic = responseObject;
           
        //名字的数组初始化
        self.nameArray = [[NSMutableArray alloc] init];
        NSEnumerator * enumeratorKey = [responseObject keyEnumerator];
        for (NSObject *object in enumeratorKey) {
            [self.nameArray addObject:object];
           // NSLog(@"遍历KEY的值: %@",object);
        }
           self.temp = [responseObject objectForKey:_nameArray[0]];
        [_leftTableView reloadData];
        [_rightTableView reloadData];
    } fail:^{
        NSLog(@"error");
    }];

}

//点击货物项目cell时弹出界面的代理函数
- (void)selectCancel{
    self.searchCtrl.searchBar.hidden = NO;
    _bigDetail.hidden = YES;
    _backView.hidden = YES;
}





- (void)detailLeftBtnSelect:(id)sender{
    int temp = [_bigDetail.num.text intValue];
    if(temp == 1){
       _bigDetail.leftBtn.hidden = YES;
    }
    temp--;
    _bigDetail.num.text =[NSString stringWithFormat:@"%d",temp];
    [_temp[_rightpath.row]setObject:_bigDetail.num.text forKey:@"num"];
    
    [_tempCell leftBtnSelect:_tempCell];
    

}
- (void)detailRightBtnSelect:(id)sender{
    [_tempCell rightBtnSelect:_tempCell];
    _bigDetail.leftBtn.hidden = NO;
    int temp = [_bigDetail.num.text intValue];
    temp++;
    _bigDetail.num.text =[NSString stringWithFormat:@"%d",temp];
    //存放到本地数组中（刷新后不改变）
    [_temp[_rightpath.row]setObject:_bigDetail.num.text forKey:@"num"];
}
- (void)bigDetailInit{
    _bigDetail.upLabel.text = _tempCell.nameLabel.text;
    _bigDetail.priceLabel.text = _tempCell.priceLabel.text;
    _bigDetail.picImage.image = _tempCell.pic.image;
   
    _bigDetail.num.text = _tempCell.num.text;
    if([_bigDetail.num.text isEqualToString:@"0"]){
        _bigDetail.leftBtn.hidden = YES;
    }
    else{
        _bigDetail.leftBtn.hidden = NO;
    }
    _backView.hidden = NO;
    _bigDetail.hidden = NO;
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=0.5;
    theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
    theAnimation.toValue=[NSNumber numberWithFloat:1.0];
    [self.bigDetail.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
}
- (void)backBtnClick:(id)sender{
    NSLog(@"here");
}

//点击低栏购物车消失
- (void)bottomAction{
    CGRect rect = _shoppingCar.frame;
    CGFloat tempY = rect.origin.y;
    [UIView beginAnimations:nil context:nil]; // 开始动画
    [UIView setAnimationDuration:0.5]; // 动画时长
    
    /**
     *  图像向下移动
     */
    rect.origin.y += kWindowHeight-tempY;
    [_shoppingCar setFrame:rect];
    [UIView commitAnimations]; // 提交动画

   // _shoppingCar.hidden = YES;
    _carBackView.hidden = YES;
    _carImage.hidden = NO;
    _goodsNumLabel.hidden = NO;
}

//购物车事件
- (void)carImageAction{
    _shoppingCar.frame = CGRectMake(0, kWindowHeight-(self.toZL.count)*50-(_bottomLabel.frame.size.height)-50, kWindowWidth, (_toZL.count)*50+50);
    
    CGFloat tempY = _shoppingCar.frame.origin.y;
    [_shoppingCar setNeedsDisplay];
    
    CGRect rect = _shoppingCar.frame;
    rect.origin.y = kWindowHeight;
    [_shoppingCar setFrame:rect];
    
    [UIView beginAnimations:nil context:nil]; // 开始动画
    [UIView setAnimationDuration:0.5]; // 动画时长
    
   
    rect.origin.y -= kWindowHeight-tempY;
    [_shoppingCar setFrame:rect];
    [UIView commitAnimations]; // 提交动画

    
    _shoppingCar.goodArray = self.toZL;
    [_shoppingCar.carGoods reloadData];
    _carBackView.hidden = NO;
    _shoppingCar.hidden = NO;
    
    
    _carImage.hidden = YES;
    _goodsNumLabel.hidden = YES;
    
    NSLog(@"%f",_shoppingCar.carGoods.frame.size.height);

}

- (void)CarViewDataReload{
    _shoppingCar.frame = CGRectMake(0, kWindowHeight-self.toZL.count*50-50-50, kWindowWidth, (self.toZL.count)*50+50);
    _shoppingCar.carGoods.frame = _shoppingCar.frame;
    [_shoppingCar setNeedsDisplay];
//    NSLog(@"%f",self.frame.origin.y);
//    NSLog(@"%lu",(unsigned long)_goodArray.count);
}

//- (void)CarViewDataReload{
//    _shoppingCar.frame = CGRectMake(0, kWindowHeight-(self.toZL.count)*50-(_bottomLabel.frame.size.height), kWindowWidth, (_toZL.count)*50);
//    _shoppingCar.carGoods.frame = _shoppingCar.frame;
//    [_shoppingCar setNeedsDisplay];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
