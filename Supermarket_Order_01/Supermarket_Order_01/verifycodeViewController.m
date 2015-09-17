//
//  verifycodeViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "verifycodeViewController.h"
#import "PwdViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
@interface verifycodeViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    NSString *_str;
    NSString*_phone;
    NSString *_areaCode;
    
}

@end

@implementation verifycodeViewController

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
    
    _verifyCodeField=[[UITextField alloc]initWithFrame:CGRectMake(80, 160, 200, 25)];
    _verifyCodeField.placeholder=@"请输入验证码" ;
    [self.view addSubview:_verifyCodeField];
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(70, 185, 200, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:line];
    
    UIButton *submitbtn=[[UIButton alloc]initWithFrame:CGRectMake(55, 200, 210, 40)];
    [submitbtn setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitbtn setTitle:@"提交验证码" forState:UIControlStateNormal];
    [submitbtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];
    
    // Do any additional setup after loading the view.
}


-(void)setPhone:(NSString*)phone AndAreaCode:(NSString*)areaCode
{
    _phone=phone;
    _areaCode=areaCode;
    
}

-(void)submit
{
    //验证号码
    //验证成功后 获取通讯录 上传通讯录
    [self.view endEditing:YES];
    
    if(self.verifyCodeField.text.length!=6)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil)
                                                      message:NSLocalizedString(@"verifycodeformaterror", nil)
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
        //传入的参数
        NSDictionary *parameters = @{@"phone_num":self.phonestr,@"code":self.verifyCodeField.text};
        //你的接口地址
        NSString *url=@"http://115.29.197.143:8999/v1.0/auth/register";
        //发送请求
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
           
            PwdViewController *pwdvc=[[PwdViewController alloc]init];
            pwdvc.register_token=responseObject[@"register_token"];
            [self presentViewController:pwdvc animated:NO completion:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        

        //[[SMS_SDK sharedInstance] commitVerifyCode:self.verifyCodeField.text];
      /*  [SMS_SDK commitVerifyCode:self.verifyCodeField.text result:^(enum SMS_ResponseState state) {
            if (1==state)
            {
                NSLog(@"验证成功");
                PwdViewController *pwdvc=[[PwdViewController alloc]init];
                [self presentViewController:pwdvc animated:NO completion:nil];
            }
            else if(0==state)
            {
                NSLog(@"验证失败");
                
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
