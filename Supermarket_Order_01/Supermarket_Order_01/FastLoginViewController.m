//
//  FastLoginViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/9.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "FastLoginViewController.h"
#import "RegisterViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPSessionManager.h"
#import "myViewController.h"
#import "OrderAppDelegate.h"
@interface FastLoginViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    UIImageView *phoneview2;
    UIButton *verifycodebtn;
    UIAlertView *alert;
    UIButton *submitbtn;
    int flag;
    OrderAppDelegate* appdelegate;
    //flag为0，快捷登录；1 普通登录
   // UIImageView *phoneview3;
}

@end

@implementation FastLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = [UIApplication sharedApplication].delegate;
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"登录"];
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
    
    _normalbtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2, 64, self.view.bounds.size.width/2, 50)];
    [_normalbtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [_normalbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [_normalbtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:_normalbtn];
    [_normalbtn setTitle:@"普通登录" forState:UIControlStateNormal];
    [_normalbtn setSelected:YES];
    [_normalbtn addTarget:self action:@selector(normallogin) forControlEvents:UIControlEventTouchUpInside];
    [_normalbtn setBackgroundImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateSelected];
    [_normalbtn setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateNormal];
    
    _fastbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width/2, 50)];
    [_fastbtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_fastbtn setTitleColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _fastbtn.selected=NO;
    [_fastbtn setTitle:@"手机快捷登录" forState:UIControlStateNormal];
    [_fastbtn setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [_fastbtn addTarget:self action:@selector(fastlogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_fastbtn];
    [_fastbtn setBackgroundImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateSelected];
    [_fastbtn setBackgroundImage:[UIImage imageNamed:@"unselected.png"] forState:UIControlStateNormal];
    
    UIImageView *phoneview=[[UIImageView alloc]initWithFrame:CGRectMake(55, 160, 25, 25)];
    [phoneview setImage:[UIImage imageNamed:@"user.png"]];
    [self.view addSubview:phoneview];
    
    verifycodebtn=[[UIButton alloc]initWithFrame:CGRectMake(255, 160, 60, 25)];
    [verifycodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    verifycodebtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [self.view addSubview:verifycodebtn];
    [verifycodebtn addTarget:self action:@selector(verify) forControlEvents:UIControlEventTouchUpInside];
    [verifycodebtn setTitleColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _phonefield=[[UITextField alloc]initWithFrame:CGRectMake(85, 160, 200, 25)];
    _phonefield.placeholder=@"请输入您的手机号码" ;
    [self.view addSubview:_phonefield];
    
    phoneview2=[[UIImageView alloc]initWithFrame:CGRectMake(55, 195, 25, 25)];
    [phoneview2 setImage:[UIImage imageNamed:@"phone.png"]];
    [self.view addSubview:phoneview2];
 

    
    _verifypwdField=[[UITextField alloc]initWithFrame:CGRectMake(85, 195, 200, 25)];
    _verifypwdField.placeholder=@"请输入您的验证码" ;
    _verifypwdField.secureTextEntry=YES;
    [self.view addSubview:_verifypwdField];
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(70, 188, 200, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:line];
    
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(70, 228, 200, 1)];
    [line2 setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    [self.view addSubview:line2];
    
    submitbtn=[[UIButton alloc]initWithFrame:CGRectMake(55, 235, 210, 40)];
    [submitbtn setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitbtn setTitle:@"登录" forState:UIControlStateNormal];
    [submitbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];

    UIButton *regbtn=[[UIButton alloc]initWithFrame:CGRectMake(260, 280, 60, 30)];
    [regbtn setTitle:@"马上注册" forState:UIControlStateNormal];
    [self.view addSubview:regbtn];
    [regbtn addTarget:self action:@selector(register) forControlEvents:UIControlEventTouchUpInside];
    [regbtn setTitleColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [regbtn setFont:[UIFont systemFontOfSize:14.0]];
    
    flag=0;
    // Do any additional setup after loading the view.
}

-(void)register{
    RegisterViewController *regvc=[[RegisterViewController alloc]init];
    [self presentViewController:regvc animated:NO completion:nil];
}

-(void)verify{
    if(self.phonefield.text.length==0){
        alert= [[UIAlertView alloc] initWithTitle:nil
                                           message:@"请输入手机号码"
                                          delegate:self
                                 cancelButtonTitle:nil otherButtonTitles:nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector: @selector(performDismiss:)  userInfo:nil repeats:NO];
        alert.delegate=self;
        [alert show];

    }
    else{
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
    }

}

- (void) performDismiss:(NSTimer *)timer {
    
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    
    
}

-(void)login{
    if(self.phonefield.text==nil||self.verifypwdField.text==nil)
        [ submitbtn setUserInteractionEnabled:NO];
    else{
        [submitbtn setUserInteractionEnabled:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
    //传入的参数
        NSDictionary *parameters;
        if(flag==1)
    parameters = @{@"phone_num":self.phonefield.text,@"password":self.verifypwdField.text};
        else
       parameters = @{@"phone_num":self.phonefield.text,@"code":self.verifypwdField.text};
    //你的接口地址
    NSString *url=@"http://115.29.197.143:8999/v1.0/auth/login";
    //发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //登录成功后！
        NSDictionary* dict = responseObject;
        appdelegate.access_token = [dict objectForKey:@"access_token"];
        myViewController* myviewcontroller = [[myViewController alloc]init];
        [self presentViewController:myviewcontroller animated:NO completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    }
    
}

-(void)fastlogin{
    flag=0;
    _fastbtn.selected=YES;
    _normalbtn.selected=NO;
    [verifycodebtn setHidden:NO];
    _verifypwdField.placeholder=@"请输入验证码";
    
}

-(void)normallogin{
    flag=1;
    [phoneview2 setImage:[UIImage imageNamed:@"pwd.png"]];
    [verifycodebtn setHidden:YES];
    _verifypwdField.placeholder=@"请输入您的密码";
    _fastbtn.selected=NO;
    _normalbtn.selected=YES;
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
