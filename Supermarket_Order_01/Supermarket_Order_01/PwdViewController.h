//
//  PwdViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdViewController : UIViewController
@property (nonatomic,strong)UIButton*backbtn;
@property(nonatomic,strong)UIButton*phonebtn;
@property(nonatomic,strong)UIButton *codebtn;
@property(nonatomic,strong)UIButton*pwdbtn;
@property(nonatomic,strong)UITextField *pwdfield;
@property(nonatomic,strong)UITextField *verifypwdField;
@property(nonatomic,strong)NSString *register_token;
@property(nonatomic,strong)UIAlertView *alert;
@end
