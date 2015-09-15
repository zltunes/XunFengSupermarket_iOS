//
//  MarketDetailVC.m
//  Final1
//
//  Created by 浩然 on 15/7/21.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "MarketDetailVC.h"
#import "commentCell.h"
#import "Header.h"
#import "MorCommentVC.h"
#import "AFtools.h"
#import "UIImageView+WebCache.h"
@interface MarketDetailVC ()<UITableViewDataSource>
    
@property (strong,nonatomic)UIImageView *marketImage;
@property (strong,nonatomic)UIToolbar *toolBar;
@property (strong,nonatomic)UITableView *commentView;
@property (strong,nonatomic)UILabel *marketText;
@property (nonatomic)NSString *next;
@property (nonatomic)NSMutableDictionary *dic;


@end

@implementation MarketDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self connectBackGround];
    _next = @"\n";
    
    UIImageView *marketImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, kWindowWidth, kWindowHeight*0.3)];
    marketImage.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:marketImage];
    _marketImage = marketImage;
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(marketImage.frame), kWindowWidth, 47)];
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(touchBtn)];
    //让跳转按钮移动到最右边
    UIBarButtonItem *fix = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width = kWindowWidth-45;
    _toolBar.items = @[fix,btn1];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithTitle:@"评价" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = btnBack;
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 60, 47)];
    label1.text = @"查看评论";
    label1.font = [UIFont boldSystemFontOfSize:14];
    [toolBar addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 80, 47)];
    label2.text = @"(共1086条)";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor grayColor];
    [toolBar addSubview:label2];

    UITableView *commentView = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(toolBar.frame), kWindowWidth-40, kWindowHeight*0.3)];
    commentView.dataSource = self;
    commentView.rowHeight = 64;
    [self.view addSubview:commentView];
    _commentView = commentView;
    
    UILabel *marketText = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(commentView.frame), kWindowWidth-40, kWindowWidth*0.3)];
    marketText.backgroundColor = [UIColor whiteColor];
    marketText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    marketText.layer.borderWidth = 1;
    marketText.lineBreakMode = UILineBreakModeWordWrap;
    marketText.numberOfLines = 0;
    marketText.font = [UIFont systemFontOfSize:13];
    marketText.textColor = [UIColor grayColor];
    
    sendTime = @"送货时间:";
    minPrice = @"起送价格:";
    marketAddr = @"超市地点:";
    timePoint = @"起送时间:";
    NSString* e = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",sendTime,_next,_next,minPrice,_next,_next,marketAddr,_next,_next,timePoint];
    marketText.text = e;
    [self.view addSubview:marketText];
    _marketText = marketText;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentCell* cell = [[commentCell alloc]init];
    
    cell.dataDic = _dic[@"comments"][indexPath.row];
        return cell;
}

- (void)touchBtn{
    MorCommentVC *morCommentVC = [[MorCommentVC alloc]init];
    morCommentVC.marId = self.marId;
    [self.navigationController pushViewController:morCommentVC animated:YES];
    
}

- (void)connectBackGround{
    NSString *url = [NSString stringWithFormat:@"%@%ld",@"http://115.29.197.143:8999/v1.0/supermarket/",(long)self.marId];
    [AFtools JSONDataWithUrl:url parameters:nil HttpHeader:nil success:^(id responseObject){
        self.dic = responseObject;
        [_marketImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dic[@"icon"]]] ];
       NSLog(@"%@",responseObject[@"comments"]);
        [self reloadTextData];
        [self.commentView reloadData];
           } fail:^{
        NSLog(@"error");
    }];
}
- (void)reloadTextData{
    sendTime = [NSString stringWithFormat:@"%@   %@%@%@",sendTime,_dic[@"start_time"],@"  -  ",_dic[@"stop_time"]];
    minPrice = [NSString stringWithFormat:@"%@   %@",minPrice,_dic[@"min_price"]];
    marketAddr = [NSString stringWithFormat:@"%@   %@",marketAddr,_dic[@"address"]];
    
    
    NSString* e = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",sendTime,_next,_next,minPrice,_next,_next,marketAddr,_next,_next,timePoint];
    _marketText.text = e;
    [_marketText reloadInputViews];
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
