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
@interface myViewController (){
    NSString *filename;
    NSMutableDictionary *plistdic;
}
@end

@implementation myViewController
@synthesize navbar;
@synthesize navitem;
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
   navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
   navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];

   UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [self.navbar addSubview:view1];
   //self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    //self.navigationItem.title=@"我的";
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
    
    //self.navigationController.navigationBar.titleTextAttributes = attrdic;
    navbar.titleTextAttributes=attrdic;
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 400)];
    [tableview registerClass:[myTableViewCell class] forCellReuseIdentifier:@"cell"];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.scrollEnabled=NO;
    [self.view addSubview:tableview];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filename= [documentsDirectory stringByAppendingPathComponent:@"personinfo.plist"];
    plistdic=[[[NSMutableDictionary alloc]initWithContentsOfFile:filename]mutableCopy];
    if(plistdic==nil){
        _islogin=NO;
        plistdic=[[NSMutableDictionary alloc]init];
        NSMutableArray *values=[[NSMutableArray alloc]initWithCapacity:10];;
        NSMutableArray *keys=[[NSMutableArray alloc]initWithCapacity:10];
        //_plistdic=[NSMutableDictionary dictionaryWithObjects:@"no",@"1.0",@"0",nil,@"0",nil forKeys:@"launch",@"version",@"count",@"userid",@"login","captain"];
    
            [values addObject:@"0"];
        [values addObject:@"0"];
        
        
            [keys addObject:@"islogin"];
        [keys addObject:@"tel"];
    
        plistdic = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
        [plistdic writeToFile:filename atomically:YES];
    }
    else{
        if([[plistdic objectForKey:@"islogin"]isEqualToString:@"1"])
            _islogin=YES;
        else
            _islogin=NO;
            
    }
    

    // Do any additional setup after loading the view.
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
        NSString *str=@"我的账户   ";
        if(_islogin==YES){
            str=[str stringByAppendingString:[plistdic objectForKey:@"tel"]];
        }
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(18,10 , 280, 20)];
        [label1 setText:str];
        [cell addSubview:label1];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(_islogin==NO){
        FastLoginViewController *regvc=[[FastLoginViewController alloc]init];
            [self presentViewController:regvc animated:NO completion:nil];
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
