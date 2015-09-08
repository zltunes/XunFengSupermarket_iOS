//
//  MorCommentVC.m
//  Final1
//
//  Created by 浩然 on 15/7/25.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "MorCommentVC.h"
#import "moreComCell.h"
#import "Header.h"

@interface MorCommentVC ()<UITableViewDataSource>
@property (nonatomic)UITableView *commentView;
@end

@implementation MorCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *commentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kWindowWidth-36, kWindowHeight)];
    commentView.rowHeight = 64;
    [self.view addSubview:commentView];
    _commentView = commentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cellId";
    moreComCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[moreComCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    return cell;

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
