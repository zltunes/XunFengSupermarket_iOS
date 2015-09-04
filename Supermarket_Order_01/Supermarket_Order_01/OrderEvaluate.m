//
//  OrderEvaluate.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OrderEvaluate.h"
#import "Header.h"
#import "OrderAppDelegate.h"

@interface OrderEvaluate ()
{
    //获取delegate对象，以访问manager属性和orderID\sup_id
    OrderAppDelegate* appDelegate;
    NSString* orderCommentsCreateURL;
}
@end
@implementation OrderEvaluate
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.evaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/2.5, 95, 117, 15)];
    self.evaluateLabel.text = @"总体评价";
    [self.view addSubview:self.evaluateLabel];
    
    self.ratingBar = [[RatingBar alloc] initWithFrame:CGRectMake(kWindowWidth/3.3,145,164,18)];
    [self.view addSubview:self.ratingBar];
    
    //是否是指示器
    self.ratingBar.isIndicator = NO;
    [self.ratingBar setImageDeselected:@"ratingbar_unselected" halfSelected:nil fullSelected:@"ratingbar_selected" andDelegate:self];
    
    //显示结果的UILabel
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(280,145,150,20)];
    [self.view addSubview:label];
    self.ratingLabel = label;
    
    self.evaluateView = [[UITextView alloc]initWithFrame:CGRectMake(15, 200, (kWindowWidth-15*2), 202)];
     self.evaluateView.delegate = self;
    self.evaluateView.text = @"亲，超市商品如何，服务是否周到";
    //设置边框
    self.evaluateView.layer.borderWidth = 1.5;
    self.evaluateView.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:self.evaluateView];
    
    self.done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishEdit)];
    
    self.submitEvaluateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitEvaluateBtn.frame = CGRectMake(30, kWindowHeight-100, kWindowWidth-60,45);
    [self.submitEvaluateBtn setBackgroundImage:[UIImage imageNamed:@"tijiaopingjia.png"] forState:UIControlStateNormal];
    //提交评价事件
    [self.submitEvaluateBtn addTarget:self action:@selector(submitEvaluate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitEvaluateBtn];
}
//为［提交评价］btn绑定事件
-(void)submitEvaluate:(id)sender
{
    if(self.rating!=0){//可以没有评价，但一定要有评分才可提交后台
    appDelegate = [UIApplication sharedApplication].delegate;
    //指定[创建评论]接口地址
    NSString* commentCreateURL1 = [NSString stringWithFormat:@"http://115.29.197.143:8999/v1.0/supermarket/%d",appDelegate.superID];
    NSString* commentCreateURL2 = @"/comment";
        orderCommentsCreateURL = [commentCreateURL1 stringByAppendingString:commentCreateURL2];
    NSDictionary* param = @{@"o_id":[NSNumber numberWithInt:appDelegate.orderID],@"content":self.evaluateView.text,@"stars":self.rating};
    [appDelegate.manager POST:orderCommentsCreateURL parameters:param
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"评价提交成功!");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"评价提交失败:%@",error);
        }];
    //评价成功后回到detailed界面
        
        
        
        
    }
}
//为导航栏设置右边按钮[开始编辑评论时]
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.evaluateView.text isEqualToString:@"亲，超市商品如何，服务是否周到"]) {
            self.evaluateView.text = nil;
    }
    self.navigationItem.rightBarButtonItem = self.done;
}
//取消导航栏右边按钮［评论结束］
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem = nil;
}
- (void)ratingChanged:(NSInteger)newRating{
    switch (newRating) {
            //评分：1——5
        case 1:
            self.rating = [NSNumber numberWithLong:newRating];
            self.ratingLabel.text = @"很差";
            break;
        case 2:
            self.rating = [NSNumber numberWithLong:newRating];
            self.ratingLabel.text = @"一般";
            break;
        case 3:
            self.rating = [NSNumber numberWithLong:newRating];
            self.ratingLabel.text = @"好";
            break;
        case 4:
            self.rating = [NSNumber numberWithLong:newRating];
            self.ratingLabel.text = @"很好";
            break;
        case 5:
            self.rating = [NSNumber numberWithLong:newRating];
            self.ratingLabel.text = @"非常好";
            break;
        default:
            break;
    }
}
//键盘消失
-(void) finishEdit
{
    //让textView控件放弃作为第一响应者
    [self.evaluateView resignFirstResponder];
}
@end
