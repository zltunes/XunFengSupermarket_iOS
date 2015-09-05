//
//  NewAddrViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "NewAddrViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"

@interface NewAddrViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    
}

@end

@implementation NewAddrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"添加收货人信息"];
    [navbar pushNavigationItem:navitem animated:NO];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    navbar.titleTextAttributes=attrdic;
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]init];
    self.backbtn=[[UIButton alloc]initWithFrame:CGRectMake(9, 30,20.5, 33)];
    [self.backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backitem setCustomView:self.backbtn];
    [navitem setLeftBarButtonItem:backitem];
    
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    UIImageView *whiteview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 72, self.view.bounds.size.width, 130)];
    [whiteview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteview];
    UILabel *addrlabel=[[UILabel alloc]initWithFrame:CGRectMake(18, 80, 60, 30)];
    [addrlabel setText:@"地址"];
    [addrlabel setTextColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:addrlabel];
    self.addressfield=[[UITextField alloc]initWithFrame:CGRectMake(82, 80, 200, 30)];
    [self.view addSubview:self.addressfield];
    self.addressfield.placeholder=@"请填写收货地址";
    UIImageView* line1=[[UIImageView alloc]initWithFrame:CGRectMake(18, 112, 284, 1)];
    line1.backgroundColor=[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [self.view addSubview:line1];
    
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(18, 120, 60, 30)];
    [phonelabel setText:@"电话"];
    [phonelabel setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [self.view addSubview:phonelabel];
    self.phonefield=[[UITextField alloc]initWithFrame:CGRectMake(82, 120, 200, 30)];
    [self.view addSubview:self.phonefield];

    UIImageView* line2=[[UIImageView alloc]initWithFrame:CGRectMake(18, 152, 284, 1)];
    line2.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    [self.view addSubview:line2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(0, 220, self.view.bounds.size.width, 50)];
    [label3 setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]];
    [self.view addSubview:label3];
    [label3 setText:@"请精确到宿舍号，方便我们送货上门哦"];
    UIButton *savebtn=[[UIButton alloc]initWithFrame:CGRectMake(55, 300, 210, 40)];
    [savebtn setBackgroundColor:[UIColor redColor]];
    [savebtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    // Do any additional setup after loading the view.
}


-(void)save{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];    //如果报接受类型不一致请替换一致text/html或别的
    
   // [manager.requestSerializer setValue:@"b07f18c8-3f14-11e5-82bd-00163e021195"forHTTPHeaderField:@"Access_token"];
    //4244b7ac-4fbb-11e5-82bd-00163e021195
    [manager.requestSerializer setValue:@"4244b7ac-4fbb-11e5-82bd-00163e021195"forHTTPHeaderField:@"Access_token"];
    //[manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"]
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    NSDictionary *parameters = @{@"phone_num":self.phonefield.text,@"address":self.addressfield.text};
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager  POST:@"http://115.29.197.143:8999/v1.0/user/address" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

    
}
-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
