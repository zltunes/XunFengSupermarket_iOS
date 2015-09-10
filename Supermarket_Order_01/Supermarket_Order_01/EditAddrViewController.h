//
//  EditAddrViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/5.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddrViewController : UIViewController
@property(nonatomic,strong)NSString* addstr;
@property(nonatomic,strong)NSString* phonestr;
@property(nonatomic,strong)UITextField *addressfield;
@property(nonatomic,strong)UITextField* phonefield;
@property(nonatomic,strong)UIButton*femalebtn;
@property(nonatomic,strong)UIButton*malebtn;
@property(nonatomic,strong)UIButton *backbtn;
@property(nonatomic,strong)NSString *addrid;
@end
