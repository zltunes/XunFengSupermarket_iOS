//
//  AboutViewController.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/9/15.
//  Copyright © 2015年 赵磊. All rights reserved.
//
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "AboutViewController.h"

@interface AboutViewController ()
{
    UINavigationBar *navbar;
    UINavigationItem*navitem;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"关于"];
    [navbar pushNavigationItem:navitem animated:NO];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    navbar.titleTextAttributes=attrdic;
//    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]init];
//    self.backbtn=[[UIButton alloc]initWithFrame:CGRectMake(9, 30,20.5, 33)];
//    [self.backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [self.backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backitem setCustomView:self.backbtn];
//    [navitem setLeftBarButtonItem:backitem];
    
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(kWindowWidth/3, 100, kWindowWidth/3, kWindowWidth/3)];
    self.imageview.image = [UIImage imageNamed:@"用户版icon_120"];
    [self.view addSubview:self.imageview];
    
    self.iconlabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/3, 120+kWindowWidth/3, kWindowWidth/3, 25)];
    self.iconlabel.text = @"掌上超市 v1.0";
    self.iconlabel.textColor = [UIColor orangeColor];
    [self.view addSubview:self.iconlabel];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, kWindowHeight/2, kWindowWidth, 120)];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cell0";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (!indexPath.row) {
        cell.textLabel.text = @"检查更新";
    } else {
        cell.textLabel.text = @"分享给好友";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"当前已是最新版！" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (indexPath.row) {
        //第三方分享
        [self share:self.view];
    }
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)share:(id)sender
{
    //构造分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"supermarket.png"]];
    NSMutableDictionary* shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"迅蜂超市"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"https://www.github.com/seuzl/XunFengSupermarket_iOS"]
                                      title:@"XunFengSupermarket_iOS"
                                       type:SSDKContentTypeApp];
    //qq空间单独制作
    [shareParams SSDKSetupQQParamsByText:@"qq空间分享"
                                   title:@"XunFengSupermarket_iOS"
                                     url:[NSURL URLWithString:@"https://www.github.com/seuzl/XunFengSupermarket_iOS"]
                              thumbImage:nil
                                   image:imageArray
                                    type:SSDKContentTypeApp
                      forPlatformSubType:SSDKPlatformSubTypeQZone];
    [ShareSDK showShareActionSheet:sender
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateBegin:
                           NSLog(@"分享开始!");
                           break;
                       case SSDKResponseStateSuccess:
                           NSLog(@"分享成功!");
                           break;
                       case SSDKResponseStateFail:
                           NSLog(@"分享失败!");
                           break;
                       case SSDKResponseStateCancel:
                           NSLog(@"分享结束!");
                           break;
                       default:
                           break;
                   }
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
