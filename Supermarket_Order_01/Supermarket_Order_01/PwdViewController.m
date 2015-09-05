//
//  PwdViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "PwdViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"

@interface PwdViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    NSString *_str;}

@end

@implementation PwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
        
        UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
        [navbar addSubview:view1];
        navitem=[[UINavigationItem alloc]initWithTitle:@"注册"];
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
        _phonebtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width/3, 50)];
        [_phonebtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        [_phonebtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_phonebtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.view addSubview:_phonebtn];
        [_phonebtn setTitle:@"输入手机号" forState:UIControlStateNormal];
        [_phonebtn setSelected:NO];
        
        _codebtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3, 64, self.view.bounds.size.width/3, 50)];
        [_codebtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_codebtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        _codebtn.selected=YES;
        [_codebtn setTitle:@"输入验证码" forState:UIControlStateNormal];
        [_codebtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        
        _pwdbtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3.0*2, 64, self.view.bounds.size.width/3, 50)];
        [_pwdbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_pwdbtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_pwdbtn setTitle:@"设置密码" forState:UIControlStateNormal];
        [_pwdbtn setSelected:NO];
        [_pwdbtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        [self.view addSubview:_pwdbtn];
        [self.view addSubview:_codebtn];
    
    [_phonebtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_codebtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_pwdbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];

    
        UIImageView *phoneview=[[UIImageView alloc]initWithFrame:CGRectMake(55, 160, 25, 25)];
        [phoneview setImage:[UIImage imageNamed:@"我的-01.png"]];
        [self.view addSubview:phoneview];
        
        _pwdfield=[[UITextField alloc]initWithFrame:CGRectMake(85, 160, 200, 25)];
        _pwdfield.placeholder=@"6-32位字母符号组合" ;
        [self.view addSubview:_pwdfield];
    
    UIImageView *phoneview2=[[UIImageView alloc]initWithFrame:CGRectMake(55, 195, 25, 25)];
    [phoneview2 setImage:[UIImage imageNamed:@"我的-01.png"]];
    [self.view addSubview:phoneview];
    
    
    
    _verifypwdField=[[UITextField alloc]initWithFrame:CGRectMake(85, 195, 200, 25)];
    _verifypwdField.placeholder=@"请您再输入设置的密码" ;
    [self.view addSubview:_verifypwdField];
    
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(70, 188, 200, 1)];
        [line setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        [self.view addSubview:line];
    
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(70, 228, 200, 1)];
    [line2 setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:line2];
    
        UIButton *submitbtn=[[UIButton alloc]initWithFrame:CGRectMake(55, 200, 210, 40)];
        [submitbtn setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
        [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitbtn setTitle:@"提交验证码" forState:UIControlStateNormal];
        [submitbtn addTarget:self action:@selector(setpwd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:submitbtn];
        
        // Do any additional setup after loading the view.
    }
    // Do any additional setup after loading the view.
-(void)setpwd{
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    //传入的参数
    NSDictionary *parameters = @{@"register_token":self.register_token,@"password":self.pwdfield.text};
    NSLog(self.register_token);
    //你的接口地址
    NSString *url=@"http://115.29.197.143:8999/v1.0/user";
    //发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
