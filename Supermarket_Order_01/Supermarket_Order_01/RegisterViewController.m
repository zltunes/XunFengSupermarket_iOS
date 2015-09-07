//
//  RegisterViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "RegisterViewController.h"
#import "verifycodeViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
@interface RegisterViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    NSString *_str;
}

@end

@implementation RegisterViewController

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
    [_phonebtn setSelected:YES];
    
    _codebtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3, 64, self.view.bounds.size.width/3, 50)];
    [_codebtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_codebtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _codebtn.selected=NO;
    [_codebtn setTitle:@"输入验证码" forState:UIControlStateNormal];
    [_codebtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    _pwdbtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3.0*2, 64, self.view.bounds.size.width/3, 50)];
    [_pwdbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_pwdbtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_pwdbtn setTitle:@"设置密码" forState:UIControlStateNormal];
    [_pwdbtn setSelected:NO];
    [_pwdbtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    [_phonebtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_codebtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_pwdbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    [self.view addSubview:_pwdbtn];
    [self.view addSubview:_codebtn];
    
    UIImageView *phoneview=[[UIImageView alloc]initWithFrame:CGRectMake(55, 160, 25, 25)];
    [phoneview setImage:[UIImage imageNamed:@"我的-01.png"]];
    [self.view addSubview:phoneview];
    
    _phonefield=[[UITextField alloc]initWithFrame:CGRectMake(80, 160, 200, 25)];
    _phonefield.placeholder=@"请输入你的手机号码" ;
    [self.view addSubview:_phonefield];
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(70, 185, 200, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:line];
    
    UIButton *registerbtn=[[UIButton alloc]initWithFrame:CGRectMake(55, 200, 210, 40)];
    [registerbtn setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [registerbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [registerbtn addTarget:self action:@selector(register) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerbtn];
    // Do any additional setup after loading the view.
}

-(void)register
{
    
    
    
    
    if (self.phonefield.text.length!=11)
        {
            //手机号码不正确
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil)
                                                          message:NSLocalizedString(@"errorphonenumber", nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    
    
    NSString* str=[NSString stringWithFormat:@"%@:%@ %@",NSLocalizedString(@"willsendthecodeto", nil),@"+86",self.phonefield.text];
    _str=[NSString stringWithFormat:@"%@",self.phonefield.text];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"surephonenumber", nil)
                                                  message:str delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                        otherButtonTitles:NSLocalizedString(@"sure", nil), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1==buttonIndex)
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
        //传入的参数
        NSDictionary *parameters = @{@"phone_num":self.phonefield.text};
        //你的接口地址
        NSString *url=@"http://115.29.197.143:8999/v1.0/auth/code";
        //发送请求
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

        
        verifycodeViewController* verify=[[verifycodeViewController alloc] init];
        verify.phonestr=self.phonefield.text;
        [self presentViewController:verify animated:NO completion:nil];
        //NSString* str2=@"86";
       /* [verify setPhone:self.phonefield.text AndAreaCode:str2];
        
        [SMS_SDK getVerificationCodeBySMSWithPhone:self.phonefield.text
                                                    zone:str2
                                                  result:^(SMS_SDKError *error)
         {
             
             if (!error)
             {
                 [self presentViewController:verify animated:NO completion:^{
                     ;
                 }];
             }
             else
             {
                 UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                               message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                     otherButtonTitles:nil, nil];
                 [alert show];
             }
             
         }];*/
    }
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
