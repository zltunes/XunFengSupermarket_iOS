//
//  FeedbackViewController.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/7.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
#import "Header.h"
#import "OrderAppDelegate.h"

@interface FeedbackViewController : UIViewController<UITextViewDelegate>
@property(nonatomic,strong)UIButton *backbtn;
@property(strong,nonatomic) UILabel* evaluateLabel;
@property(strong,nonatomic) UITextView* evaluateView;
@property(strong,nonatomic) UIButton* submitEvaluateBtn;
@property(strong,nonatomic) UILabel* ratingLabel;
@property(strong,nonatomic) UIBarButtonItem* done;
@property(strong,nonatomic) RatingBar *ratingBar;
@property(strong,nonatomic) NSNumber* rating;
@end
