//
//  MorCommentVC.m
//  Final1
//
//  Created by 浩然 on 15/7/25.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "MorCommentVC.h"
#import "moreComCell.h"
#import "AFtools.h"
#import "Header.h"

@interface MorCommentVC ()<UITableViewDataSource>
@property (nonatomic)UITableView *commentView;
@end

@implementation MorCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectBackGround];
    // Do any additional setup after loading the view.
    UITableView *commentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kWindowWidth-36, kWindowHeight)];
    commentView.dataSource = self;
    commentView.rowHeight = 64;
    [self.view addSubview:commentView];
    _commentView = commentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dic.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    moreComCell* cell = [[moreComCell alloc]init];
   
    cell.commentDic = self.dic[indexPath.row];
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    return cell;

}
- (void)connectBackGround{
    NSString *url = [NSString stringWithFormat:@"%@%ld%@",@"http://115.29.197.143:8999/v1.0/supermarket/",(long)self.marId,@"/comments"];
    [AFtools JSONDataWithUrl:url parameters:nil HttpHeader:nil success:^(id responseObject){
        self.dic = responseObject;

        //NSLog(@"%@",_dic[0]);
        [self.commentView reloadData];
    } fail:^{
        NSLog(@"error");

    }];
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
