//
//  FastLoginViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/9.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastLoginViewController : UIViewController<UIAlertViewDelegate>
@property(nonatomic,strong)UIButton *backbtn;
@property(nonatomic,strong)UIButton *fastbtn;
@property(nonatomic,strong)UIButton *normalbtn;
@property(nonatomic,strong)UITextField *phonefield;
@property(nonatomic,strong)UITextField *verifypwdField;
@end
