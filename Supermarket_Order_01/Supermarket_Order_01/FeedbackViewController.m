//
//  FeedbackViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    UITextView *textview;
    OrderAppDelegate* appDelegate;
}

@end

@implementation FeedbackViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.evaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/6, 95, 0.75*kWindowWidth, 15)];
    self.evaluateLabel.text = @"为我们的软件打个分吧！";
    self.evaluateLabel.textAlignment = UITextAlignmentCenter;
    [self.evaluateLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:self.evaluateLabel];
    
    self.ratingBar = [[RatingBar alloc] initWithFrame:CGRectMake(kWindowWidth/3.3,145,164,18)];
    [self.view addSubview:self.ratingBar];
    
    //是否是指示器
    self.ratingBar.isIndicator = NO;
    [self.ratingBar setImageDeselected:@"ratingbar_unselected" halfSelected:nil fullSelected:@"ratingbar_selected" andDelegate:self];
    
    //显示结果的UILabel
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(260,145,150,20)];
    label.textColor = [UIColor orangeColor];
    [self.view addSubview:label];
    self.ratingLabel = label;
    
    self.evaluateView = [[UITextView alloc]initWithFrame:CGRectMake(15, 200, (kWindowWidth-15*2), 202)];
    self.evaluateView.delegate = self;
    self.evaluateView.text = @"请留下您的宝贵意见，我们将努力改正!";
    //设置边框
    self.evaluateView.layer.borderWidth = 1.5;
    self.evaluateLabel.highlighted = YES;
    self.evaluateView.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:self.evaluateView];
    
    self.done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishEdit)];
    
    self.submitEvaluateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitEvaluateBtn.frame = CGRectMake(30, kWindowHeight-100, kWindowWidth-60,42);
    [self.submitEvaluateBtn setBackgroundImage:[UIImage imageNamed:@"tijiaofankui.png"] forState:UIControlStateNormal];
    //提交评价事件
    [self.submitEvaluateBtn addTarget:self action:@selector(submitEvaluate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitEvaluateBtn];
}

-(void)submitEvaluate:(id)sender
{
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//为导航栏设置右边按钮[开始编辑评论时]
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.evaluateView.text isEqualToString:@"请留下您的宝贵意见，我们将努力改正!"]) {
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


- (void)viewDidLoad {
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"意见反馈"];
    [navbar pushNavigationItem:navitem animated:NO];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    navbar.titleTextAttributes=attrdic;
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]init];
//    self.backbtn=[[UIButton alloc]initWithFrame:CGRectMake(9, 30,20.5, 33)];
//    [self.backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [self.backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backitem setCustomView:self.backbtn];
//    [navitem setLeftBarButtonItem:backitem];
}
//
//-(void)textViewDidBeginEditing:(UITextView *)textView {
//    if ([textView.text isEqualToString:@"想说的话"]) {
//        textView.text = @"";
//    }
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView {
//    if (textView.text.length<1) {
//        textView.text = @"想说的话";
//    }
//}
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
