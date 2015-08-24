//
//  OrderEvaluate.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/25.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingBar.h"
@interface OrderEvaluate : UIViewController<UITextViewDelegate>

@property(strong,nonatomic) UILabel* evaluateLabel;
@property(strong,nonatomic) UITextView* evaluateView;
@property(strong,nonatomic) UIButton* submitEvaluateBtn;
@property(strong,nonatomic) UILabel* ratingLabel;
@property(strong,nonatomic) UIBarButtonItem* done;
@property(strong,nonatomic) RatingBar *ratingBar;
@property(strong,nonatomic) NSNumber* rating;

@end
