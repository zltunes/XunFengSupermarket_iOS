//
//  myViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/7/15.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "myViewController.h"
#import "myTableViewCell.h"
#import "mylogisticsViewController.h"
#import "AddressViewController.h"
#import "RegisterViewController.h"
#import "CouponViewController.h"
#import "HelpViewController.h"
#import "FeedbackViewController.h"
#import "FastLoginViewController.h"
#import "OrderAppDelegate.h"

@interface myViewController (){
    OrderAppDelegate* delegate;
    UIButton *logoutbtn;
    UILabel *label1;
}
@end

@implementation myViewController
@synthesize navbar;
@synthesize navitem;
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    delegate = [UIApplication sharedApplication].delegate;
     self.islogin = delegate.islogin;
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
   navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
   navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];

   UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [self.navbar addSubview:view1];

    navitem=[[UINavigationItem alloc]initWithTitle:nil];
    [navbar pushNavigationItem:navitem animated:NO];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithTitle:@"修改密码" style:UIBarButtonItemStylePlain target:self action:@selector(changepwd)];
    //[self.navigationItem setRightBarButtonItem:rightitem];
    [navitem setRightBarButtonItem:rightitem];
    //self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    
    navbar.titleTextAttributes=attrdic;
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 400)];
    [tableview registerClass:[myTableViewCell class] forCellReuseIdentifier:@"cell"];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.scrollEnabled=NO;
    logoutbtn=[[UIButton alloc]initWithFrame:CGRectMake(50, self.view.bounds.size.height-100, self.view.bounds.size.width-100, 40)];
    [logoutbtn setTitle:@"退 出 登 录" forState:UIControlStateNormal];
    [logoutbtn.layer setMasksToBounds:YES];
    [logoutbtn.layer setCornerRadius:10.0];
    [logoutbtn.layer setBorderWidth:2.0];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
    [logoutbtn.layer setBorderColor:color];

    [self.view addSubview:logoutbtn];
    [logoutbtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutbtn setTitleColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    if(!_islogin)
        [logoutbtn setHidden:YES];
    [self.view addSubview:tableview];

    _islogin = delegate.islogin;
}

-(void)logout{
    NSLog(@"退出！");
    //更新delegate.plistdic
    [delegate.plistdic setObject:@"0" forKey:@"islogin"];
    [delegate.plistdic setObject:@"" forKey:@"access_token"];
    [delegate.plistdic setObject:@"" forKey:@"tel"];
    [delegate.plistdic writeToFile:delegate.filename atomically:NO];
    //更新delegate
    delegate.islogin = NO;
    delegate.access_token = @"";
    [delegate.manager.requestSerializer setValue:nil forHTTPHeaderField:@"access_token"];
    //重新加载viewcontroller
    [delegate.viewController initOrderView];
    self.islogin = NO;
    [logoutbtn setHidden:YES];
    NSIndexPath* indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    myTableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexpath];
    cell.leftlabel.text = @"我的账户";
//    [label1 setHidden:YES];
    [self.tableview reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==4)
        return 4;
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"cell";
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    [cell setupcell];
 
    if(indexPath.section==0){
        [cell.leftimg setImage:[UIImage imageNamed:@"我的-01.png"]];
        NSString *str=@"我的账户            ";
        if(_islogin==YES){
            str=[str stringByAppendingString:[delegate.plistdic objectForKey:@"tel"]];
        }
//        label1=[[UILabel alloc]initWithFrame:CGRectMake(18,10 , 280, 20)];
//        [label1 setText:str];
//        [cell addSubview:label1];
        
        [cell.leftlabel setText:str];
        [cell.leftlabel sizeToFit];
    }
    //NSUInteger row = [indexPath row];
    if(indexPath.section==1){
        [cell.leftimg setImage: [UIImage imageNamed:@"物流-01.png"]];
        [cell.leftlabel setText:@"申请物流"];
        
    }
    else if(indexPath.section==2){
        [cell.leftimg setImage: [UIImage imageNamed:@"地址管理-01.png"]];
        [cell.leftlabel setText:@"地址管理"];
    }
    
    else if (indexPath.section==3){
        [cell.leftimg setImage:[UIImage imageNamed:@"账户余额-01.png"]];
        [cell.leftlabel setText:@"余额"];
    }
    
    else if(indexPath.section==4){
        if(indexPath.row==0){
        [cell.leftimg setImage:[UIImage imageNamed:@"意见反馈-01.png"]];
            [cell.leftlabel setText:@"意见反馈"];
        }
        else if (indexPath.row==1){
            [cell.leftimg setImage:[UIImage imageNamed:@"客服电话-01.png"]];
            [cell.leftlabel setText:@"客服电话"];
        }
        else if (indexPath.row==2){
            [cell.leftimg setImage:[UIImage imageNamed:@"帮助手册-01.png"]];
            [cell.leftlabel setText:@"帮助手册"];
        }
        else if (indexPath.row==3){
            [cell.leftimg setImage:[UIImage imageNamed:@"关于-01.png"]];
            [cell.leftlabel setText:@"关于"];
        }
    }
    
    return cell;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self setHidesBottomBarWhenPushed:NO];
    [super viewDidDisappear:animated];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(_islogin==NO){
        FastLoginViewController *regvc=[[FastLoginViewController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationItem.backBarButtonItem setTitle:@"返回"];
            [self.navigationController pushViewController:regvc animated:YES];
        }
    
            
    }
    if(indexPath.section==1){
        mylogisticsViewController *logisticsvc=[[mylogisticsViewController alloc]init];
        //[self.navigationController pushViewController:logisticsvc animated:YES];
        [self presentViewController:logisticsvc animated:NO completion:nil];
    }
    if(indexPath.section==2){
        AddressViewController *addressvc=[[AddressViewController alloc]init];
       // [self.navigationController pushViewController:addressvc animated:NO];
        [self presentViewController:addressvc animated:NO completion:nil];
    }
    if(indexPath.section==3){
        CouponViewController *couponvc=[[CouponViewController alloc]init];
        [self presentViewController:couponvc animated:NO completion:nil];
    }
    if(indexPath.section==4){
        if(indexPath.row==0){
            FeedbackViewController *feedvc=[[FeedbackViewController alloc]init];
            [self presentViewController:feedvc animated:NO completion:nil];
        
        }
        if(indexPath.row==1){
            NSString *number = @"10086";// 此处读入电话号码
            
            // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
            
            
            
            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
            
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
        }
    if(indexPath.row==2){
        HelpViewController *helpvc=[[HelpViewController alloc]init];
        [self presentViewController:helpvc animated:NO completion:nil];
    }
    }
    [self.tableview deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)changepwd{
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
